import config

import sqlalchemy


class Engine:
    """Database engine construction"""

    host = config.host
    port = config.port
    user = config.username
    password = config.password
    database = config.database
    database_engine = config.database_engine

    def __call__(self):
        connect_args = dict(connect_timeout=config.connection_timeout)
        return sqlalchemy.create_engine(self.db_uri, connect_args=connect_args)

    @property
    def db_uri(self) -> str:
        """Database URI"""
        endpoint = f"{self.host}:{self.port}"
        authority = f"{self.user}:{self.password}"
        return f"{self.database_engine}://{authority}@{endpoint}/{self.database}"


engine_maker = Engine()
