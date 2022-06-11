const fetch = require('node-fetch');
const fs = require('fs');
const fpath = require('path');

const fetchCurrencies = ['Currency', 'Fragment'];
const fetchCurrencyOverview = async (type, league = 'Sentinel') => {
    const request = await fetch(`https://poe.ninja/api/data/CurrencyOverview?league=${league}&type=${type}&language=en`);
    const json = await request.json()
    const lines = json.lines;
    const items = lines.reduce((obj, ln) => ({
        ...obj,
        [ln.currencyTypeName]: ln.chaosEquivalent
    }), {})
    return items;
}

const fetchItems = ['Oil', 'Incubator', 'Map', 'BlightedMap', 'UniqueMap', 'DeliriumOrb', 'Scarab', 'Fossil', 'Resonator', 'Essence', 'SkillGem'];
const fetchItemOverview = async (type, league = 'Sentinel') => {
    const request = await fetch(`https://poe.ninja/api/data/ItemOverview?league=${league}&type=${type}&language=en`);
    const json = await request.json()
    const lines = json.lines;
    const items = lines.reduce((obj, ln) =>
        (typeof ln.gemLevel !== 'undefined' && (ln.gemLevel > 1 || ln.chaosValue < 15)) ||
        (typeof ln.mapTier !== 'undefined' && (ln.itemClass === 2 && ln.mapTier < 14))
    ? obj : ({
        ...obj,
        [ln.name]: ln.chaosValue
    }), {})
    return items;
}

(async () => {
    let obj = {
        'Chaos Orb': 1,
        'Contract': 3,
        'Blueprint': 10,
        'Rogue\'s Marker': 0.004,
        'Occupied Map': 20
    };
    const currencies = await Promise.all(fetchCurrencies.map((type) => fetchCurrencyOverview(type)));
    const items = await Promise.all(fetchItems.map((type) => fetchItemOverview(type)));
    const combined = [
        ...currencies,
        ...items
    ];
    combined.forEach((sub) => {
        obj = {
            ...obj,
            ...sub
        }
    });
    obj = {
        ...obj,
        'Ritual Splinter': obj['Ritual Vessel'] / 100
    }

    const ahk = `
ITEMS_OF_INTEREST := {}
${Object.keys(obj).map(key => `ITEMS_OF_INTEREST["${key}"] := ${obj[key]}`).join('\n')}
    `.trim();

    const path = fpath.resolve(__dirname, '../', 'Lib', 'Prices_Poe.ahk');
    fs.writeFileSync(path, ahk, 'utf-8');

    // Fetch artifact prices
    const artifacts = await fetchItemOverview('Artifact');

    const mapArtifacts = {
        'Grand Black Scythe Artifact': 'GRAND',
        'Greater Black Scythe Artifact': 'GREATER',
        'Common Black Scythe Artifact': 'COMMON',
        'Lesser Black Scythe Artifact': 'LESSER',
        'Exotic Coinage': 'COIN'
    }

    const artifactAhk = `
CURRENCY := {}
${Object.keys(mapArtifacts).map(key => `CURRENCY["${mapArtifacts[key]}"] := ${artifacts[key]}`).join('\n')}
    `.trim();

    const artifactCsv = `
    ${Object.keys(mapArtifacts).map(key => `${mapArtifacts[key]},${artifacts[key]}`).join('\n')}
    `.trim()

    // const pPath = fpath.resolve(__dirname, '../', 'Lib', 'Prices.ahk');
    // bfs.writeFileSync(pPath, artifactAhk, 'utf-8');
    const cPath = fpath.resolve(__dirname, '../', 'Tujen_Prices.csv');
    fs.writeFileSync(cPath, artifactCsv, 'utf-8');
})()