//
//  File.swift
//
//
//  Created by Tibor Bodecs on 03/12/2023.
//

import NIOCore
import SQLiteNIO
import SQLiteKit
import AsyncKit
import Logging

extension EventLoopGroupConnectionPool where Source == SQLiteConnectionSource {

    func database(logger: Logger) -> any SQLiteDatabase {
        _EventLoopGroupConnectionPoolSQLiteDatabase(pool: self, logger: logger)
    }
}

extension EventLoopConnectionPool where Source == SQLiteConnectionSource {

    func database(logger: Logger) -> any SQLiteDatabase {
        _EventLoopConnectionPoolSQLiteDatabase(pool: self, logger: logger)
    }
}

private struct _EventLoopGroupConnectionPoolSQLiteDatabase: SQLiteDatabase {

    let pool: EventLoopGroupConnectionPool<SQLiteConnectionSource>
    let logger: Logger

    var eventLoop: any EventLoop { self.pool.eventLoopGroup.any() }

    func query(
        _ query: String,
        _ binds: [SQLiteData],
        logger: Logger,
        _ onRow: @escaping @Sendable (SQLiteRow) -> Void
    ) -> EventLoopFuture<Void> {
        pool.withConnection(
            logger: logger,
            { $0.query(query, binds, logger: logger, onRow) }
        )
    }

    func withConnection<T>(
        _ closure: @escaping @Sendable (SQLiteConnection) ->
            EventLoopFuture<T>
    ) -> EventLoopFuture<T> {
        pool.withConnection(logger: logger, closure)
    }
}

private struct _EventLoopConnectionPoolSQLiteDatabase: SQLiteDatabase {
    let pool: EventLoopConnectionPool<SQLiteConnectionSource>
    let logger: Logger

    var eventLoop: any EventLoop { pool.eventLoop }

    func query(
        _ query: String,
        _ binds: [SQLiteData],
        logger: Logger,
        _ onRow: @escaping @Sendable (SQLiteRow) -> Void
    ) -> EventLoopFuture<Void> {
        pool.withConnection(
            logger: logger,
            { $0.query(query, binds, logger: logger, onRow) }
        )
    }

    func withConnection<T>(
        _ closure: @escaping @Sendable (SQLiteConnection) ->
            EventLoopFuture<T>
    ) -> EventLoopFuture<T> {
        pool.withConnection(logger: logger, closure)
    }
}
