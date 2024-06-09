dialogOpen = false;
resourceName = null;
showCamera = true;
buttonClicked = {};
window.addEventListener('message', function(event) {
    ed = event.data;
    if (ed.action === "openDialog") {
		if (ed.menuAlign === "left") {
			document.getElementById("mainDiv").style.left = 0;
		} else {
			document.getElementById("mainDiv").style.right = 0;
		}
		buttonClicked = {};
        dialogOpen = true;
		showCamera = ed.showCam;
		if (showCamera === false) {
			document.getElementById("MDDivType2TopDivRightCircle").classList.remove("MDDivType2TopDivRightCircleDeactive");
			document.getElementById("MDDivType2TopDivRightCircle").classList.add("MDDivType2TopDivRightCircleActive");
		} else {
			document.getElementById("MDDivType2TopDivRightCircle").classList.remove("MDDivType2TopDivRightCircleActive");
			document.getElementById("MDDivType2TopDivRightCircle").classList.add("MDDivType2TopDivRightCircleDeactive");
		}
		document.getElementById("mainDiv").style.display = "flex";
		resourceName = ed.resourceName;
		let label1 = "";
		if (ed.menuData.Label.split(" ")[0]) {
			label1 = ed.menuData.Label.split(" ")[0];
		}
		let label2 = "";
		if (ed.menuData.Label.split(" ")[1]) {
			label2 = ed.menuData.Label.split(" ")[1];
		}
		document.getElementById("topTitle1").innerHTML=label1 + `<span>${label2}</span>`;
		document.getElementById("MDDivType2TopDivLeft").innerHTML=`<i class="${ed.menuData.Icon}"></i><h4>${label1}<span>${label2}</span></h4>`;
		document.getElementById("topDescription").innerHTML=ed.menuData.Description;
		document.getElementById("MDDivType1InsideIconDiv").innerHTML=`<i class="${ed.menuData.Icon}"></i>`;
		// Text Area
		document.getElementById("MDDivType2BottomDiv").innerHTML="";
		if (ed.autoMessages) {
			ed.autoMessages.forEach(function(messageData, index) {
				if (messageData.type === "question") {
					var messagesHTML = `
					<div id="MDDivType2BDTarget">
						<div id="MDDivType2BDTargetLine"></div>
						<div id="MDDivType2BDTextDiv">${messageData.text}</div>
						<div id="MDDivType2BDIconDiv">
							<i class="fas fa-question-circle"></i>
						</div>
					</div>`;
				} else {
					var messagesHTML = `
					<div id="MDDivType2BDTarget">
						<div id="MDDivType2BDTargetLine"></div>
						<div id="MDDivType2BDTextDiv">${messageData.text}</div>
						<div id="MDDivType2BDIconDiv"></div>
					</div>`;
				}
				appendHtml(document.getElementById("MDDivType2BottomDiv"), messagesHTML);
			})
		}
		// Buttons
		document.getElementById("MDDivType3").innerHTML="";
		ed.buttons.forEach(function(buttonData, index) {
			let a = buttonData.systemAnswer.text.replace(/'/g, '');
			let b = buttonData.playerAnswer.text.replace(/'/g, '');
			var buttonsHTML = `
			<div class="MDDivType3Btn MDDivType3BtnDefault" id="MDDivType3Btn-${buttonData.label}" onclick="clFunc('answer', '${a}', '${buttonData.systemAnswer.type}', '${buttonData.systemAnswer.enable}', '${b}', '${buttonData.playerAnswer.enable}', '${buttonData.id}', '${buttonData.label}', '${buttonData.maxClick}')">
				<div class="MDDivType3BtnNumber">${buttonData.id}</div>
				<div class="MDDivType3BtnText">${buttonData.label}</div>
			</div>`;
			appendHtml(document.getElementById("MDDivType3"), buttonsHTML);
			buttonClicked[buttonData.label] = 0;
		})
	} else if (ed.action === "closeMenu") {
		dialogOpen = false;
		document.getElementById("mainDiv").style.display = "none";
	}
    document.onkeyup = function(data) {
		if (data.which == 27 && dialogOpen) {
            dialogOpen = false;
			document.getElementById("mainDiv").style.display = "none";
			var xhr = new XMLHttpRequest();
			xhr.open("POST", `https://${resourceName}/callback`, true);
			xhr.setRequestHeader('Content-Type', 'application/json');
			xhr.send(JSON.stringify({action: "nuiFocus"}));
		}
	}
})

function clFunc(action1, action2, action3, action4, action5, action6, action7, action8, action9) {
	if (action1 === "camera") {
		var xhr = new XMLHttpRequest();
		xhr.open("POST", `https://${resourceName}/callback`, true);
		xhr.setRequestHeader('Content-Type', 'application/json');
		xhr.send(JSON.stringify({action: "camera", state: showCamera}));
		showCamera = !showCamera;
		if (showCamera === false) {
			document.getElementById("MDDivType2TopDivRightCircle").classList.remove("MDDivType2TopDivRightCircleDeactive");
			document.getElementById("MDDivType2TopDivRightCircle").classList.add("MDDivType2TopDivRightCircleActive");
		} else {
			document.getElementById("MDDivType2TopDivRightCircle").classList.remove("MDDivType2TopDivRightCircleActive");
			document.getElementById("MDDivType2TopDivRightCircle").classList.add("MDDivType2TopDivRightCircleDeactive");
		}
	} else if (action1 === "closeMenu") {
		dialogOpen = false;
		document.getElementById("mainDiv").style.display = "none";
		var xhr = new XMLHttpRequest();
		xhr.open("POST", `https://${resourceName}/callback`, true);
		xhr.setRequestHeader('Content-Type', 'application/json');
		xhr.send(JSON.stringify({action: "nuiFocus"}));
	} else if (action1 === "answer") {
		if (buttonClicked[action8] < Number(action9)) {
			buttonClicked[action8] = buttonClicked[action8] + 1;
			var xhr = new XMLHttpRequest();
			xhr.open("POST", `https://${resourceName}/callback`, true);
			xhr.setRequestHeader('Content-Type', 'application/json');
			xhr.send(JSON.stringify({action: "onClick", id: Number(action7)}));
			if (action2 && action4 === "true") {
				if (action3 === "question") {
					var messageHTML = `
					<div id="MDDivType2BDTarget">
						<div id="MDDivType2BDTargetLine"></div>
						<div id="MDDivType2BDTextDiv">${action2}</div>
						<div id="MDDivType2BDIconDiv">
							<i class="fas fa-question-circle"></i>
						</div>
					</div>`;
					appendHtml(document.getElementById("MDDivType2BottomDiv"), messageHTML);
				} else {
					var messageHTML = `
					<div id="MDDivType2BDTarget">
						<div id="MDDivType2BDTargetLine"></div>
						<div id="MDDivType2BDTextDiv">${action2}</div>
						<div id="MDDivType2BDIconDiv"></div>
					</div>`;
					appendHtml(document.getElementById("MDDivType2BottomDiv"), messageHTML);
				}
			}
			setTimeout(() => {
				if (action5 && action6 === "true") {
					var messageHTML = `
					<div id="MDDivType2BDMe">
						<div id="MDDivType2BDMeTextDiv">${action5}</div>
						<div id="MDDivType2BDMeTargetLine"></div>
					</div>`;
					appendHtml(document.getElementById("MDDivType2BottomDiv"), messageHTML);
				}
			}, 500);
			var objDiv = document.getElementById("MDDivType2BottomDiv");
			objDiv.scrollTop = objDiv.scrollHeight;
		}
		if (buttonClicked[action8] === Number(action9)) {
			document.getElementById("MDDivType3Btn-" + action8).classList.add("MDDivType3BtnClicked");
			document.getElementById("MDDivType3Btn-" + action8).classList.remove("MDDivType3BtnDefault");
		}
	}
}

function appendHtml(el, str) {
	var div = document.createElement('div');
	div.innerHTML = str;
	while (div.children.length > 0) {
		el.appendChild(div.children[0]);
	}
}