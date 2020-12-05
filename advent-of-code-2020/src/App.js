import './App.css';


function Calculate() {
    const input = document.getElementsByTagName('input')[0];

    if (input) {
        const inputList = input.value.split(' ');

        const testingList = inputList;

        inputList.forEach((item, index) => {
            testingList.forEach((testItem, index) => {
                const sum = Number(item) + Number(testItem);
                if (sum === 2020) {
                    const result = Number(item) * Number(testItem);
                    document.getElementsByClassName('output')[0].innerHTML = result;
                }
            })
        });
    }
}

function Calculate2() {
    const input = document.getElementsByTagName('input')[1];

    if (input) {
        const inputList = input.value.split(' ');

        const testingList1 = inputList;
        const testingList2 = inputList;

        inputList.forEach((item) => {
            testingList1.forEach((testItem1) => {
                testingList2.forEach((testItems2) => {
                    const sum = Number(item) + Number(testItem1) + Number(testItems2);
                    if (sum === 2020) {
                        const result = Number(item) * Number(testItem1) * Number(testItems2);
                        document.getElementsByClassName('output')[1].innerHTML = result;
                    }
                })
            })
        });
    }
}


function validPassCount() {
    const input = document.getElementsByTagName('textarea')[0];
    if (input) {
        let counter = 0;

        const list = input.value.split('\n');

        list.forEach((item) => {
            const atributes = item.split(':')[0].split(' ');

            const min = atributes[0].split('-')[0];
            const max = atributes[0].split('-')[1];

            const letter = atributes[1];

            const pass = item.split(': ')[1];

            let innerCounter = 0;

            for (let i in pass) {
                if (pass[i] === letter) {
                    innerCounter++;
                }
            }

            if (innerCounter >= min && innerCounter <= max) {
                counter++;
            }
        });

        document.getElementsByClassName('output')[2].innerHTML = 'Nr of valid pass: ' + counter;
    }

}


function validPassCount2() {
    const input = document.getElementsByTagName('textarea')[1];
    if (input) {
        let counter = 0;

        const list = input.value.split('\n');

        list.forEach((item) => {
            const atributes = item.split(':')[0].split(' ');

            const pos1 = Number(atributes[0].split('-')[0]) - 1;
            const pos2 = Number(atributes[0].split('-')[1]) - 1;

            const letter = atributes[1];

            const pass = item.split(': ')[1];

            if ((pass[pos1] === letter && pass[pos2] !== letter) || (pass[pos1] !== letter && pass[pos2] === letter)) {
                counter++;
            }

        });

        document.getElementsByClassName('output')[3].innerHTML = 'Nr of valid pass: ' + counter;
    }

}



function countTrees() {
    const input = document.getElementsByTagName('textarea')[2];
    if (input) {
        let treeCounter = 0;
        const tree = '#';

        let columnIndex = 0;

        const rows = input.value.split('\n');

        for (let i in rows) {
            const n = 15;
            for (let d = 0; d < n; d++) {
                rows[i] += rows[i];
            }
        }

        rows.forEach((item, index) => {
            if (index !== 0) {

                columnIndex = columnIndex + 3;
                if (item[columnIndex] === tree) {
                    treeCounter++;
                }
            }
        })

        document.getElementsByClassName('output')[4].innerHTML = 'Nr of trees: ' + treeCounter;
    }

}




function countTrees2() {
    const input = document.getElementsByTagName('textarea')[3];
    if (input) {
        let treeCounter = 0;

        const tree = '#';

        const rows = input.value.split('\n');

        for (let i in rows) {
            const n = 15;
            for (let d = 0; d < n; d++) {
                rows[i] += rows[i];
            }
        }

        const slopes = [
            '1 1',
            '3 1',
            '5 1',
            '7 1',
            '1 2'
        ]

        slopes.forEach((slope) => {
            const right = Number(slope.split(' ')[0]);
            const down = Number(slope.split(' ')[1]);

            let slopeCounter = 0;

            let x = right;
            for (let y = down; y < rows.length; y = y + down) {
                if (rows[y][x] === tree) {
                    slopeCounter++;
                }
                x = x + right;
            }

            treeCounter = treeCounter === 0 ? slopeCounter : treeCounter * slopeCounter;
        })

        document.getElementsByClassName('output')[5].innerHTML = 'Nr of trees: ' + treeCounter;
    }

}


function validPassports() {
    const input = document.getElementsByTagName('textarea')[4];

    const passPortList = input.value.split('\n\n');

    const required = [
        'byr',
        'iyr',
        'eyr',
        'hgt',
        'hcl',
        'ecl',
        'pid'
    ]

    let validCounter = 0;

    passPortList.forEach(item => {
        const values = item.split(/[\s\n]+/);

        const cidIndex = values.findIndex(elem => elem.includes('cid'));

        if (cidIndex !== -1) {
            values.splice(cidIndex, 1);
        }

        if (values.length >= required.length) {
            validCounter++;
        }
    });


    document.getElementsByClassName('output')[6].innerHTML = 'Nr of valid Passports: ' + validCounter;
}


function validPassports2() {
    const input = document.getElementsByTagName('textarea')[5];

    const passPortList = input.value.split('\n\n');

    const required = [
        'byr',
        'iyr',
        'eyr',
        'hgt',
        'hcl',
        'ecl',
        'pid'
    ]

    let validCounter = 0;

    passPortList.forEach(item => {
        const values = item.split(/[\s\n]+/);

        const cidIndex = values.findIndex(elem => elem.includes('cid'));

        if (cidIndex !== -1) {
            values.splice(cidIndex, 1);
        }

        if (values.length >= required.length) {
            let innerCounter = 0;

            values.forEach(value => {
                const fields = value.split(':');

                if (fields[0] === required[0]) {
                    if (fields[1].length && Number(fields[1]) >= 1920 && Number(fields[1]) <= 2002) {
                        innerCounter++;
                    }
                }

                if (fields[0] === required[1]) {
                    if (fields[1].length && Number(fields[1]) >= 2010 && Number(fields[1]) <= 2020) {
                        innerCounter++;
                    }
                }

                if (fields[0] === required[2]) {
                    if (fields[1].length && Number(fields[1]) >= 2020 && Number(fields[1]) <= 2030) {
                        innerCounter++;
                    }
                }

                if (fields[0] === required[3]) {
                    if (fields[1].includes('cm')) {
                        if (Number(fields[1].slice(0, -2)) >= 150 && Number(fields[1].slice(0, -2)) <= 193) {
                            innerCounter++;
                        }
                    }
                    if (fields[1].includes('in')) {
                        if (Number(fields[1].slice(0, -2)) >= 59 && Number(fields[1].slice(0, -2)) <= 76) {
                            innerCounter++;
                        }
                    }
                }

                if (fields[0] === required[4]) {
                    if (fields[1].includes('#') && fields[1].match(/[0-9a-f]+/g) && fields[1].length === 7) {
                        innerCounter++;
                    }
                }

                if (fields[0] === required[5]) {
                    if (fields[1] === 'amb' || fields[1] === 'blu' || fields[1] === 'brn' || fields[1] === 'gry' || fields[1] === 'grn' || fields[1] === 'hzl' || fields[1] === 'oth') {
                        innerCounter++;
                    }
                }

                if (fields[0] === required[6]) {
                    if (fields[1].match(/[0-9]+/g) && fields[1].length === 9) {
                        innerCounter++;
                    }
                }

            });

            if (innerCounter === required.length) {
                validCounter++;
            }
        }
    });


    document.getElementsByClassName('output')[7].innerHTML = 'Nr of valid Passports: ' + validCounter;
}


function getHighestSeat() {
    const input = document.getElementsByTagName('textarea')[6];

    let highestScore = 0;

    const numberOfRows = 127;
    const numberOfColumns = 7;

    const seats = input.value.split('\n');

    seats.forEach(seat => {
        let minRow = 0;
        let maxRow = numberOfRows;

        let minCol = 0;
        let maxCol = numberOfColumns;

        let incValue = 0;

        let rowScore = 0;
        let colScore = 0;

        const rowCode = seat.slice(0, seat.length - 3);
        const columnCode = seat.slice(seat.length - 3);

        for (let i in rowCode) {
            incValue = Math.round((maxRow - minRow) / 2);

            if (rowCode[i] === 'F') {
                //maxRow = Math.round((maxRow / 2) + (minRow / 2));
                maxRow = maxRow - incValue;
                if (i == rowCode.length - 1) {
                    rowScore = minRow;
                }
            } else {
                //minRow = Math.round((minRow / 2) + (maxRow / 2));
                minRow = minRow + incValue;
                if (i == rowCode.length - 1) {
                    rowScore = maxRow;
                }
            }
        }

        for (let i in columnCode) {
            incValue = Math.round((maxCol - minCol) / 2);

            if (columnCode[i] === 'L') {
                //maxRow = Math.round((maxRow / 2) + (minRow / 2));
                maxCol = maxCol - incValue;
                if (i == columnCode.length - 1) {
                    colScore = minCol;
                }
            } else {
                //minRow = Math.round((minRow / 2) + (maxRow / 2));
                minCol = minCol + incValue;
                if (i == columnCode.length - 1) {
                    colScore = maxCol;
                }
            }
        }

        const score = rowScore * 8 + colScore;

        highestScore = score > highestScore ? score : highestScore;
    });

    document.getElementsByClassName('output')[8].innerHTML = 'The highest seat is: ' + highestScore;
}

function getMySeat() {
    const input = document.getElementsByTagName('textarea')[7];

    const numberOfRows = 127;
    const numberOfColumns = 7;

    const seats = input.value.split('\n');

    const listOfScores = [];

    seats.forEach(seat => {
        let minRow = 0;
        let maxRow = numberOfRows;

        let minCol = 0;
        let maxCol = numberOfColumns;

        let incValue = 0;

        let rowScore = 0;
        let colScore = 0;

        const rowCode = seat.slice(0, seat.length - 3);
        const columnCode = seat.slice(seat.length - 3);

        for (let i in rowCode) {
            incValue = Math.round((maxRow - minRow) / 2);

            if (rowCode[i] === 'F') {
                //maxRow = Math.round((maxRow / 2) + (minRow / 2));
                maxRow = maxRow - incValue;
                if (i == rowCode.length - 1) {
                    rowScore = minRow;
                }
            } else {
                //minRow = Math.round((minRow / 2) + (maxRow / 2));
                minRow = minRow + incValue;
                if (i == rowCode.length - 1) {
                    rowScore = maxRow;
                }
            }
        }

        for (let i in columnCode) {
            incValue = Math.round((maxCol - minCol) / 2);

            if (columnCode[i] === 'L') {
                //maxRow = Math.round((maxRow / 2) + (minRow / 2));
                maxCol = maxCol - incValue;
                if (i == columnCode.length - 1) {
                    colScore = minCol;
                }
            } else {
                //minRow = Math.round((minRow / 2) + (maxRow / 2));
                minCol = minCol + incValue;
                if (i == columnCode.length - 1) {
                    colScore = maxCol;
                }
            }
        }

        const score = rowScore * 8 + colScore;

        listOfScores.push(score);
    });

    let seatScore = 0;

    listOfScores.sort((a, b) => a - b);

    listOfScores.forEach((score, index) => {
        if (listOfScores[index + 1] == score + 2) {
            seatScore = score + 1;
        }
    });


    document.getElementsByClassName('output')[9].innerHTML = 'The seat is: ' + seatScore;
}

function App() {
    return (
        <div className="App">
            <h1>Advent of Code 2020</h1>
            <br />

            <h1>Day 1</h1>
            <br />
            <div>
                <input type='text' id='inputId' className='input' />
                <button className='button' onClick={() => Calculate()}>
                    Go
                </button>
                <br />
                <div className='output' />
            </div>
            <br />
            <div>
                <input type='text' id='inputId' className='input' />
                <button className='button' onClick={() => Calculate2()}>
                    Go
                </button>
                <br />
                <div className='output' />
            </div>
            <h1>Day 2</h1>
            <br />
            <div>
                <textarea type='text' id='textareaId' className='textarea' />
                <button className='button' onClick={() => validPassCount()}>
                    Go
                </button>
                <br />
                <div className='output' />
            </div>
            <br />
            <div>
                <textarea type='text' id='textareaId' className='textarea' />
                <button className='button' onClick={() => validPassCount2()}>
                    Go
                </button>
                <br />
                <div className='output' />
            </div>
            <h1>Day 3</h1>
            <br />
            <div>
                <textarea type='text' id='textareaId' className='textarea' />
                <button className='button' onClick={() => countTrees()}>
                    Go
                </button>
                <br />
                <div className='output' />
            </div>

            <br />
            <div>
                <textarea type='text' id='textareaId' className='textarea' />
                <button className='button' onClick={() => countTrees2()}>
                    Go
                </button>
                <br />
                <div className='output' />
            </div>

            <h1>Day 4</h1>
            <br />
            <div>
                <textarea type='text' id='textareaId' className='textarea' />
                <button className='button' onClick={() => validPassports()}>
                    Go
                </button>
                <br />
                <div className='output' />
            </div>

            <br />
            <div>
                <textarea type='text' id='textareaId' className='textarea' />
                <button className='button' onClick={() => validPassports2()}>
                    Go
                </button>
                <br />
                <div className='output' />
            </div>

            <h1>Day 5</h1>
            <br />
            <div>
                <textarea type='text' id='textareaId' className='textarea' />
                <button className='button' onClick={() => getHighestSeat()}>
                    Go
                </button>
                <br />
                <div className='output' />
            </div>

            <br />
            <div>
                <textarea type='text' id='textareaId' className='textarea' />
                <button className='button' onClick={() => getMySeat()}>
                    Go
                </button>
                <br />
                <div className='output' />
            </div>

        </div>
    );
}

export default App;
