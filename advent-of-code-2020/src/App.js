import './App.css';


function Calculate(){
    const input = document.getElementsByTagName('input')[0];

    if(input){
     const inputList = input.value.split(' ');
    
      const testingList = inputList;

     inputList.forEach((item, index) => {
         testingList.forEach((testItem, index) => {
                const sum = Number(item) + Number(testItem);
                if(sum === 2020){
                    const result = Number(item) * Number(testItem);
                    document.getElementsByClassName('output')[0].innerHTML = result;
                }
            })
        });
    }
}

function Calculate2(){
    const input = document.getElementsByTagName('input')[1];

    if(input){
        const inputList = input.value.split(' ');
    
        const testingList1 = inputList;
        const testingList2 = inputList;

        inputList.forEach((item) => {
        testingList1.forEach((testItem1) => {
            testingList2.forEach((testItems2) => {
                const sum = Number(item) + Number(testItem1) + Number(testItems2);
                    if(sum === 2020){
                        const result = Number(item) * Number(testItem1) * Number(testItems2);
                        document.getElementsByClassName('output')[1].innerHTML = result;
                    }
                })    
            })
        });
    }
}


function validPassCount(){
    const input = document.getElementsByTagName('textarea')[0];
    if(input){
        let counter = 0;

        const list = input.value.split('\n');
        
        list.forEach((item) => {
            const atributes = item.split(':')[0].split(' ');
            
            const min = atributes[0].split('-')[0];
            const max = atributes[0].split('-')[1];

            const letter = atributes[1];

            const pass = item.split(': ')[1];
            
            let innerCounter = 0;
            
            for(let i in pass){
                if(pass[i] === letter){
                    innerCounter++;
                }
            }

            if(innerCounter >= min && innerCounter <= max){
                counter++;
            }
        });

        document.getElementsByClassName('output')[2].innerHTML = 'Nr of valid pass: ' + counter;
    }

}


function validPassCount2(){
    const input = document.getElementsByTagName('textarea')[1];
    if(input){
        let counter = 0;

        const list = input.value.split('\n');
        
        list.forEach((item) => {
            const atributes = item.split(':')[0].split(' ');
            
            const pos1 = Number(atributes[0].split('-')[0]) - 1;
            const pos2 = Number(atributes[0].split('-')[1]) - 1;

            const letter = atributes[1];

            const pass = item.split(': ')[1];
            
            if((pass[pos1] === letter && pass[pos2] != letter) || (pass[pos1] != letter && pass[pos2] === letter)) {
                counter++;
            }

        });

        document.getElementsByClassName('output')[3].innerHTML = 'Nr of valid pass: ' + counter;
    }

}



function App() {
  return (
      <div className="App">
            <h1>Advent of Code 2020</h1>
            <br/>
      
            <h1>Day 1</h1>
            <div>
                <input type='text' id='inputId' className='input'/>
                <button className='button' onClick={() => Calculate()}>
                    Go
                </button>
                <br/>
                <div className='output'/>
            </div>
            <div>
                <input type='text' id='inputId' className='input'/>
                <button className='button' onClick={() => Calculate2()}>
                    Go
                </button>
                <br/>
                <div className='output'/>
            </div>
            <h1>Day 2</h1>
            <div>
                <textarea type='text' id='textareaId' className='textarea'/>
                <button className='button' onClick={() => validPassCount()}>
                    Go
                </button>
                <br/>
                <div className='output'/>
            </div>
            <div>
                <textarea type='text' id='textareaId' className='textarea'/>
                <button className='button' onClick={() => validPassCount2()}>
                    Go
                </button>
                <br/>
                <div className='output'/>
            </div>

        </div>
  );
}

export default App;
