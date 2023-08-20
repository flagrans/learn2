function createTable(tx) {
    const sql =
    'CREATE TABLE IF NOT EXISTS capitals (' +
    'capital_id INTEGER PRIMARY KEY,' +
    'country TEXT NOT NULL,' +
    'capital TEXT' +
    ');'
    tx.executeSql(sql)
}

function addCapital(tx, country, capital) {
    const sql =
    'INSERT INTO capitals (country, capital)' +
    'VALUES("%1", "%2");'.arg(country).arg(capital)
    return tx.executeSql(sql)
}

function updateCapital(tx, id, text, header) {
    var sql = 'UPDATE capitals SET ' + header + '=? WHERE capital_id=?;'
    var data = [text, id]
    return tx.executeSql(sql, data)
}

function delCapital(tx, id) {
    var sql = 'DELETE FROM capitals WHERE capital_id=?;'
    var data = [id]
    return tx.executeSql(sql, data)
}

function readCapitals(tx, model) {
    const sql = 'SELECT capital_id, country, capital FROM capitals';
    var result = tx.executeSql(sql);

    for(var i = 0; i < result.rows.length; ++i) {
        model.appendRow({
                            id: result.rows.item(i).capital_id,
                            country: result.rows.item(i).country,
                            capital: result.rows.item(i).capital,
                            del: ""
                        })
    }
}
