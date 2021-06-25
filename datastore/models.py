from datetime import datetime

from sqlalchemy.orm import relationship
from sqlalchemy import (
    Column,
    DateTime,
    Integer,
    ForeignKey,
    String,
    BigInteger,
    DECIMAL,
)
from sqlalchemy.ext.declarative import declarative_base, DeferredReflection

from datastore.engine import engine_maker

Base = declarative_base(cls=DeferredReflection)
db_engine = engine_maker()


class User(Base):
    """
    User model
    """

    __tablename__ = "user"

    id = Column(Integer, primary_key=True)
    username = Column(String(20), unique=True, nullable=False)
    email = Column(String(120), unique=True, nullable=False)
    password = Column(String(60), nullable=False)
    products = relationship("Products", backref="owner", lazy=True)


class Products(Base):
    """
    Products manager
    """

    __tablename__ = "products"

    id = Column(Integer, nullable=False, primary_key=True, autoincrement=True)
    user_id = Column(Integer, ForeignKey("user.id"), nullable=False)
    product_name = Column(String(100), nullable=False)
    product_description = Column(String(550))
    category = Column(String(50), nullable=False)
    minimum_bid = Column(BigInteger, nullable=False)
    post_created = Column(DateTime, default=datetime.now().replace(microsecond=0))
    last_updated = Column(DateTime, default=datetime.now().replace(microsecond=0))
    last_date_to_bid = Column(DateTime, default=datetime.now().replace(microsecond=0))
    bids = relationship("Bidder", backref="products", lazy=True, cascade="all,delete,delete-orphan")
    picture = Column(String(1600), nullable=False, default="default.png")


class Bidder(Base):
    """
    Bidding
    """

    __tablename__ = "bidder"

    id = Column(Integer, primary_key=True, autoincrement=True)
    bidders_id = Column(Integer, nullable=False)
    product_id = Column(Integer, ForeignKey("products.id"), nullable=False)
    bid_value = Column(DECIMAL, nullable=False, default=0)
    note = Column(String(500))
