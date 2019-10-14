class GenNumber extends React.Component {
  componentDidUpdate() {
	let time, digit;
	// increase showing time depend on level
	digit = this.props.level.main + 2;
	time = 110 * Math.min(digit, 5) + 400 * Math.max(digit - 5, 0);

	let number = document.getElementById('number');
	setTimeout(function () {
	  number.innerHTML = number.innerHTML.replace(/\w/gi, '&#183;');
	}, time);

  }
  componentDidMount() {
	let number = document.getElementById('number');
	setTimeout(function () {
	  number.innerHTML = number.innerHTML.replace(/\w|\W/gi, '&#183;');
	}, 1200);
  }
  render() {
	return (
	  React.createElement("div", { className: "app__gen-number" },
	  React.createElement("div", { className: "app__info" },
	  React.createElement("p", { className: "app__level" }, "Nivel: ", this.props.level.main, " - ", this.props.level.sub),
	  React.createElement("p", { className: "app__wrong" }, "Erros: ", this.props.wrong, "/2")),

	  React.createElement("p", { className: "app__divider" }, "############################"),
	  React.createElement("p", { className: "app__number", id: "number" }, this.props.wrong < 2 ? atob(this.props.question) : '????'),
	  React.createElement("p", { className: "app__divider" }, "############################")));


  }}


class InputNumber extends React.Component {
  constructor() {
	super();
	this.handleUserInput = this.handleUserInput.bind(this);
	this.handleReset = this.handleReset.bind(this);
  }
  handleUserInput(e) {
	e.preventDefault();
	let userNumber = btoa(this.userNumber.value);
	this.userNumber.value = "";
	this.props.compareUserInput(userNumber);
  }
  handleReset() {
	this.props.onReset();
  }
  render() {
	let layout;
	if (this.props.wrong < 2) {
	  layout = React.createElement("div", { className: "app__input" },
	  React.createElement("form", { onSubmit: this.handleUserInput }, "O numero é:",

	  React.createElement("input", {
		pattern: "[0-9]+",
		type: "text",
		ref: ref => this.userNumber = ref,
		required: true,
		autoFocus: true }),
	  React.createElement("br", null),
	  React.createElement("br", null)),

	  React.createElement("button", { onClick: this.handleReset }, "Cancelar"),
	  React.createElement("button", { onClick: this.handleUserInput, className: "app__send" }, "Testar código"));
	} else {
	  layout = React.createElement("div", { className: "app__end" },
	  React.createElement("div", { class: "app__notify" }, "Tenha sorte na próxima vez. (\u2727\u03C9\u2727)"), React.createElement("br", null), React.createElement("br", null), React.createElement("button", { onClick: this.handleReset }, "Cancelar"));

	}

	return layout;
  }}


class App extends React.Component {
  constructor() {
	super();
	this.compareUserInput = this.compareUserInput.bind(this);
	this.randomGenerate = this.randomGenerate.bind(this);
	this.resetState = this.resetState.bind(this);
	this.state = {
	  question: btoa(this.randomGenerate(2)),
	  level: { main: 1, sub: 1 },
	  wrong: 0 };

  }
	resetState() {
		this.setState({
		question: btoa(this.randomGenerate(2)),
		level: { main: 1, sub: 1 },
		wrong: 0 });
	
	}
	randomGenerate(digit) {
		let max = Math.pow(10, digit) - 1,
		min = Math.pow(10, digit - 1);
	
		return Math.floor(Math.random() * (max - min + 1)) + min;
	}
	compareUserInput(userNumber) {
		let currQuestion = this.state.question,
		mainLevel = this.state.level.main,
		subLevel = this.state.level.sub,
		wrong = this.state.wrong,
		digit;

		if (userNumber == currQuestion) {
			if (subLevel < 3) {
				++subLevel;
			} 
			else if (subLevel == 3) {
				++mainLevel;
				subLevel = 1;
			}
		} else {
			++wrong;
		}
		digit = mainLevel + 2;
		
		let enviou = 0;
		if (mainLevel == 5 && subLevel == 3){
			currQuestion = 1;
			digit = 2;
			mainLevel = 1;
			subLevel = 1;
			enviou = 0;
			wrong = 0;
			$('#ATMSection').hide();
			$.post('http://crz_celetronico/ganhou', JSON.stringify({}));
		} 

		window.addEventListener('message', function( event ) {
			if (enviou == 0 ) {
				if ( event.data.action == 'receiveDados' ) {
					var nivel = event.data.nivel;
					var subnivel = event.data.subnivel;
					if (nivel != undefined)   {
						if (mainLevel == nivel && subLevel == subnivel){
							$.post('http://crz_celetronico/policia', JSON.stringify({}));
							enviou = 1;
						}
					}
				}
			}
		});

		if (wrong == 2) {
			currQuestion = 1;
			digit = 2;
			mainLevel = 1;
			subLevel = 1;
			enviou = 0;
			wrong = 0;
			$('#ATMSection').hide();
			$.post('http://crz_celetronico/perdeu', JSON.stringify({}));
		}
	
		this.setState({
			question: btoa(this.randomGenerate(digit)),
			level: { main: mainLevel, sub: subLevel },
			wrong: wrong 
		});
	}
	
	render() {
	return (
		React.createElement("div", { className: "main__app" },
			React.createElement(GenNumber, {
				question: this.state.question,
				level: this.state.level,
				wrong: this.state.wrong 
			}),
			React.createElement(InputNumber, {
				compareUserInput: this.compareUserInput,
				wrong: this.state.wrong,
				onReset: this.resetState 
			})
		));
	}}

	// LUA event listener
	window.addEventListener('message', function( event ) {
		if ( event.data.action == 'start' ) {
			var atm = event.data.atm;
		  $('#ATMSection').show();
			setTimeout(function() {
			  ReactDOM.render(
			  React.createElement(App, null),
			  document.getElementById('app'));
			}, 3000);
		}
		if ( event.data.action == 'close' ) {
			$('#ATMSection').hide();
			$.post('http://crz_celetronico/escape', JSON.stringify({}));
		}
	});

	// Close NUI - Escape key event
	$(document).keyup(function(e) {
		if (e.keyCode == 120) {
			$('#ATMSection').hide();
			$.post('http://crz_celetronico/escape', JSON.stringify({}));
		}
	});