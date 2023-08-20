function createTable(tx) {
    const sql =
    'CREATE TABLE IF NOT EXISTS products (' +
    'product_id INTEGER PRIMARY KEY,' +
    'product TEXT NOT NULL,' +
    'manufacturer TEXT,' +
    'price DOUBLE' +
    ');'
    tx.executeSql(sql)
}

function addProduct(tx, product, manufacturer, price) {
    const sql =
    'INSERT INTO products (product, manufacturer, price)' +
    'VALUES("%1", "%2", "%3");'.arg(product).arg(manufacturer).arg(parseFloat(price))
    return tx.executeSql(sql)
}

function updateProduct(tx, id, text, header) {
    var sql = 'UPDATE products SET ' + header + '=? WHERE product_id=?;'
    var data = [text, id]
    return tx.executeSql(sql, data)
}

function delProduct(tx, id) {
    var sql = 'DELETE FROM products WHERE product_id=?;'
    var data = [id]
    return tx.executeSql(sql, data)
}

function readProducts(tx, model) {
    const sql = 'SELECT product_id, product, manufacturer, price FROM products';
    var result = tx.executeSql(sql);

    for(var i = 0; i < result.rows.length; ++i) {
        model.appendRow({
                            id: result.rows.item(i).product_id,
                            product: result.rows.item(i).product,
                            manufacturer: result.rows.item(i).manufacturer,
                            price: result.rows.item(i).price,
                            del: ""
                        })
    }
}
