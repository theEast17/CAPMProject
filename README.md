# Getting Started

Welcome to your new project.

It contains these folders and files, following our recommended project layout:

File or Folder | Purpose
---------|----------
`app/` | content for UI frontends goes here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`package.json` | project metadata and configuration
`readme.md` | this getting started guide


## Next Steps

- Open a new terminal and run `cds watch`
- (in VS Code simply choose _**Terminal** > Run Task > cds watch_)
- Start adding content, for example, a [db/schema.cds](db/schema.cds).


## Learn More

Learn more at https://cap.cloud.sap/docs/get-started/.

### **Important OData API Queries for Your CAPM Project**  

Since you have exposed your entities in `CatalogService`, you can perform operations like filtering, sorting, and expanding data using **OData Query Parameters**.

---

## **1. Basic API Endpoints**  
### **Get All Purchase Orders**
```bash
GET /odata/v4/CatalogService/purchaseorder
```
- Returns all purchase orders.

### **Get a Specific Purchase Order by Key**
```bash
GET /odata/v4/CatalogService/purchaseorder(PO_ID='123456')
```
- Fetches a single purchase order where `PO_ID = '123456'`.

---

## **2. Filtering (`$filter`)**
Filtering allows you to retrieve specific records based on conditions.

### **Get Purchase Orders for a Specific Business Partner**
```bash
GET /odata/v4/CatalogService/purchaseorder?$filter=PARTNER_GUID eq 'BP001'
```
- Fetches all purchase orders where `PARTNER_GUID = 'BP001'`.

### **Get All Active Purchase Orders**
```bash
GET /odata/v4/CatalogService/purchaseorder?$filter=LIFECYCLE_STATUS eq 'A'
```
- Retrieves all purchase orders with lifecycle status **'A'**.

### **Get Products Where Price is Greater Than 100**
```bash
GET /odata/v4/CatalogService/product?$filter=price gt 100
```
- Fetches products where `price > 100`.

### **Filter Multiple Conditions (`AND` & `OR`)**
```bash
GET /odata/v4/CatalogService/purchaseorder?$filter=LIFECYCLE_STATUS eq 'A' and OVERALL_STATUS eq 'C'
```
- Fetches active purchase orders with overall status **'C'**.

```bash
GET /odata/v4/CatalogService/product?$filter=price gt 100 or category eq 'Electronics'
```
- Fetches products where `price > 100` OR `category = 'Electronics'`.

---

## **3. Sorting (`$orderby`)**
Sorting results in ascending (`asc`) or descending (`desc`) order.

### **Sort Products by Price (Ascending)**
```bash
GET /odata/v4/CatalogService/product?$orderby=price asc
```

### **Sort Purchase Orders by PO ID (Descending)**
```bash
GET /odata/v4/CatalogService/purchaseorder?$orderby=PO_ID desc
```

### **Sort Products by Category and then by Price**
```bash
GET /odata/v4/CatalogService/product?$orderby=category asc, price desc
```
- Sorts products by **category** in ascending order.
- Within the same category, products are sorted by **price** in descending order.

---

## **4. Pagination (`$top` & `$skip`)**
Used for large datasets to retrieve only a limited number of records.

### **Get First 10 Purchase Orders (`$top`)**
```bash
GET /odata/v4/CatalogService/purchaseorder?$top=10
```

### **Skip First 5 Records and Get Next 10 (`$skip`)**
```bash
GET /odata/v4/CatalogService/purchaseorder?$skip=5&$top=10
```
- Useful for implementing **pagination**.

---

## **5. Expanding Associations (`$expand`)**
Used to retrieve related entities in a **single request**.

### **Get Purchase Orders Along with Their Items**
```bash
GET /odata/v4/CatalogService/purchaseorder?$expand=Items
```
- Retrieves **purchase orders** along with their associated **poitems**.

### **Get Business Partners Along with Their Addresses**
```bash
GET /odata/v4/CatalogService/businesspartner?$expand=address
```
- Retrieves **business partners** along with their **addresses**.

---

## **6. Selecting Specific Fields (`$select`)**
Used to return only the required fields.

### **Get Only PO ID and Partner GUID from Purchase Orders**
```bash
GET /odata/v4/CatalogService/purchaseorder?$select=PO_ID,PARTNER_GUID
```
- Retrieves only `PO_ID` and `PARTNER_GUID` from the purchase order.

### **Get Product Name and Price Only**
```bash
GET /odata/v4/CatalogService/product?$select=name,price
```
---

## **7. Combining `$filter`, `$orderby`, and `$expand`**
You can combine multiple OData parameters.

### **Example: Get Purchase Orders Where Lifecycle Status = 'A', Sorted by PO ID, Including Items**
```bash
GET /odata/v4/CatalogService/purchaseorder?$filter=LIFECYCLE_STATUS eq 'A'&$orderby=PO_ID desc&$expand=Items
```
- Filters purchase orders with `LIFECYCLE_STATUS = 'A'`.
- Sorts by `PO_ID` in descending order.
- Expands related `poitems`.

---

## **8. Searching (`$search`)**
If full-text search is enabled in CAPM, you can use `$search` for quick lookups.

### **Search for Products Containing 'Laptop'**
```bash
GET /odata/v4/CatalogService/product?$search=Laptop
```
- Returns all products where any searchable field contains "Laptop".

---

## **9. Counting Records (`$count`)**
Used to retrieve the number of records matching a query.

### **Get Total Number of Purchase Orders**
```bash
GET /odata/v4/CatalogService/purchaseorder/$count
```
- Returns the **count** of all purchase orders.

### **Count Purchase Orders with Lifecycle Status = 'A'**
```bash
GET /odata/v4/CatalogService/purchaseorder?$filter=LIFECYCLE_STATUS eq 'A'&$count=true
```
- Returns the count of purchase orders with `LIFECYCLE_STATUS = 'A'`.

---

## **10. Calling Custom Functions**
Since you defined a **custom function** `getHighestSalary()` in `salary` service, you can call it like this:

```bash
GET /odata/v4/salary/getHighestSalary()
```
- Returns the **highest salary** from the `worker` entity.

---

## **Next Steps**
✅ Test these APIs in **Postman** or **SAP Business Application Studio (BAS)**.  
✅ Implement **error handling** for incorrect inputs.  
✅ Extend your service by adding **custom actions**.  

Let me know if you need more details! 🚀
