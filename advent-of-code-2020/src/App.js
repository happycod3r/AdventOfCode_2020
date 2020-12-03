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



function App() {
  return (
      <div className="App">
            <div>
            <h1>Day 1</h1>
                <input type='text' id='inputId' className='input'/>
                <button className='button' onClick={() => Calculate()}>
                    Go
                </button>
                <br/>
                <div className='output'/>
            </div>
            <div>
            <h1>Day 2</h1>
                <input type='text' id='inputId' className='input'/>
                <button className='button' onClick={() => Calculate2()}>
                    Go
                </button>
                <br/>
                <div className='output'/>
            </div>

        </div>
  );
}

export default App;
