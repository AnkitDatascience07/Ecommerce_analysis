# Data Dictionary: Target Brazil E-commerce Dataset

## Database Schema Overview

The Target Brazil dataset consists of 8 interconnected tables containing comprehensive e-commerce transaction data from September 2016 to October 2018.


## Table Definitions

### 1. `orders`
**Purpose:** Core transaction table containing order lifecycle information
**Records:** 99,441 orders

| Column | Data Type | Description |
|--------|-----------|-------------|
| `order_id` | STRING | Unique identifier for each order |
| `customer_id` | STRING | Foreign key linking to customers table |
| `order_status` | STRING | Current status: delivered, shipped, processing, canceled, etc. |
| `order_purchase_timestamp` | TIMESTAMP | Date and time when order was placed |
| `order_approved_at` | TIMESTAMP | When order payment was approved |
| `order_delivered_carrier_date` | TIMESTAMP | When order was delivered to carrier |
| `order_delivered_customer_date` | TIMESTAMP | When customer received the order |
| `order_estimated_delivery_date` | TIMESTAMP | Estimated delivery date provided to customer |

**Key Business Fields:**
- Use `order_purchase_timestamp` for trend analysis
- Calculate delivery performance with `order_delivered_customer_date` - `order_purchase_timestamp`
- Measure accuracy with `order_delivered_customer_date` vs `order_estimated_delivery_date`

### 2. `customers`
**Purpose:** Customer demographic and geographic information
**Records:** 99,441 unique customers

| Column | Data Type | Description |
|--------|-----------|-------------|
| `customer_id` | STRING | Unique customer identifier (links to orders) |
| `customer_unique_id` | STRING | Unique customer identifier across all orders |
| `customer_zip_code_prefix` | INTEGER | First 5 digits of customer postal code |
| `customer_city` | STRING | Customer city name |
| `customer_state` | STRING | Brazilian state code (2 letters) |

**Key Business Fields:**
- Use `customer_state` for geographic analysis
- `customer_city` provides granular location insights
- `customer_zip_code_prefix` links to geolocation table

### 3. `order_items`
**Purpose:** Product details and pricing for each item within orders
**Records:** 112,650 items (multiple items per order possible)

| Column | Data Type | Description |
|--------|-----------|-------------|
| `order_id` | STRING | Links to orders table |
| `order_item_id` | INTEGER | Sequential item number within order |
| `product_id` | STRING | Links to products table |
| `seller_id` | STRING | Links to sellers table |
| `shipping_limit_date` | TIMESTAMP | Seller shipping deadline |
| `price` | FLOAT | Item price in Brazilian Real (BRL) |
| `freight_value` | FLOAT | Shipping cost for this item (BRL) |

**Key Business Fields:**
- `price` for revenue analysis
- `freight_value` for logistics cost analysis
- `order_item_id` indicates multi-item orders

### 4. `payments`
**Purpose:** Payment method and transaction details
**Records:** 103,886 payment records

| Column | Data Type | Description |
|--------|-----------|-------------|
| `order_id` | STRING | Links to orders table |
| `payment_sequential` | INTEGER | Sequential payment number for installments |
| `payment_type` | STRING | Payment method: credit_card, debit_card, voucher, etc. |
| `payment_installments` | INTEGER | Number of installments (1 = single payment) |
| `payment_value` | FLOAT | Payment amount in BRL |

**Key Business Fields:**
- `payment_type` for payment preference analysis
- `payment_installments` for credit behavior insights
- `payment_value` for financial calculations

### 5. `products`
**Purpose:** Product catalog information and specifications
**Records:** 32,951 unique products

| Column | Data Type | Description |
|--------|-----------|-------------|
| `product_id` | STRING | Unique product identifier |
| `product_category_name` | STRING | Product category (Portuguese names) |
| `product_name_length` | INTEGER | Length of product name string |
| `product_description_length` | INTEGER | Length of product description |
| `product_photos_qty` | INTEGER | Number of product photos |
| `product_weight_g` | INTEGER | Product weight in grams |
| `product_length_cm` | INTEGER | Product length in centimeters |
| `product_height_cm` | INTEGER | Product height in centimeters |
| `product_width_cm` | INTEGER | Product width in centimeters |

**Key Business Fields:**
- `product_category_name` for category performance analysis
- Physical dimensions for logistics planning
- `product_photos_qty` for merchandising insights

### 6. `sellers`
**Purpose:** Seller/vendor information and location
**Records:** 3,095 sellers

| Column | Data Type | Description |
|--------|-----------|-------------|
| `seller_id` | STRING | Unique seller identifier |
| `seller_zip_code_prefix` | INTEGER | Seller postal code (first 5 digits) |
| `seller_city` | STRING | Seller city location |
| `seller_state` | STRING | Seller state code |

**Key Business Fields:**
- `seller_state` for supply chain geographic analysis
- Compare seller vs customer locations for shipping optimization

### 7. `order_reviews`
**Purpose:** Customer satisfaction and feedback data
**Records:** 99,224 reviews

| Column | Data Type | Description |
|--------|-----------|-------------|
| `review_id` | STRING | Unique review identifier |
| `order_id` | STRING | Links to orders table |
| `review_score` | INTEGER | Rating from 1-5 stars |
| `review_comment_title` | STRING | Review title/heading |
| `review_comment_message` | STRING | Review text content |
| `review_creation_date` | TIMESTAMP | When review was submitted |
| `review_answer_timestamp` | TIMESTAMP | When review was responded to |

**Key Business Fields:**
- `review_score` for satisfaction analysis
- `review_creation_date` for feedback timeline
- Text fields for sentiment analysis (advanced use)

### 8. `geolocation`
**Purpose:** Brazilian postal code coordinate mapping
**Records:** 1,000,163 location records

| Column | Data Type | Description |
|--------|-----------|-------------|
| `geolocation_zip_code_prefix` | INTEGER | Postal code (first 5 digits) |
| `geolocation_lat` | FLOAT | Latitude coordinate |
| `geolocation_lng` | FLOAT | Longitude coordinate |
| `geolocation_city` | STRING | City name |
| `geolocation_state` | STRING | State code |

**Key Business Fields:**
- Links customer and seller locations to coordinates
- Enables distance calculations for delivery analysis
- Supports mapping and geographic visualization

## Data Quality Notes

### Completeness
- Orders table: 100% complete for core fields
- Delivery dates: ~96% completion rate
- Reviews: ~99% of orders have associated reviews
- Geographic data: Complete coverage of Brazilian postal codes

### Data Types
- All timestamps in UTC format
- Monetary values in Brazilian Real (BRL)
- State codes follow Brazilian standard (2-letter codes)
- Coordinates in decimal degrees format

### Key Relationships
- One customer can have multiple orders
- One order can contain multiple items
- One order can have multiple payment installments
- Geographic data provides lat/lng for postal codes

## Business Context

### Brazilian State Codes
Common states in the dataset:
- **SP:** São Paulo (largest market)
- **RJ:** Rio de Janeiro (second largest)
- **MG:** Minas Gerais (interior market)
- **RS:** Rio Grande do Sul (southern region)
- **PR:** Paraná (southern region)

### Payment Types
- **credit_card:** Credit card payments (most common)
- **debit_card:** Debit card payments  
- **voucher:** Gift cards/vouchers
- **not_defined:** Payment method not specified

### Order Status Values
- **delivered:** Successfully completed orders
- **shipped:** Orders in transit
- **processing:** Orders being prepared
- **canceled:** Canceled orders
- **unavailable:** Product unavailable

This data dictionary provides the foundation for understanding and analyzing Target's Brazilian e-commerce operations effectively.
