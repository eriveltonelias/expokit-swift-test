import React, { Component } from 'react';
import { NativeModules, StyleSheet, Text, View, TextInput, TouchableOpacity, Alert } from 'react-native';
import { Video } from 'expo'
import { Feather } from '@expo/vector-icons'

export default class App extends Component {
	constructor(props){
		super(props)
		this.state = {
			text : '',
			urlVideo : null,
			enableVideo : false
		}
	}
	_closeVideo = () => {
		return this.setState({ enableVideo : false })
	}
  	_showVideo = ( data ) => {
		return this.setState({enableVideo : true, urlVideo : data.video })
	}
	_openNativeScreen = () => {
		//NativeModules.VideoController.openNativeScreen()
	}  
  	_openNative = () => {
		let { text } = this.state
		if(text.length === 0){
			Alert.alert('Please, insert a text!')
			return false
		}
		NativeModules.VideoController.showVideo(text, (data) => this._showVideo(data))
  	}
  	render() {
    	return (
			<View style={styles.container}>
				{this.state.enableVideo && this.state.urlVideo ?
					<View style = {styles.videoContainer}>
						<TouchableOpacity style = {styles.iconClose} onPress = {() => this._closeVideo()}> 
							<Feather name = 'x' color = '#FFFFFF' size = {35} />
						</TouchableOpacity>
						<View style = {styles.videoBox}>
							<Video
								source={{ uri: this.state.urlVideo }}
								rate={1.0}
								volume={1.0}
								isMuted={false}
								resizeMode="cover"
								shouldPlay
								style={{ width: 300, height: 300}}
							/>
						</View>
					</View>
					:
					<View>
						<TextInput style = {styles.input} 
							placeholder = 'Type an text'
							onChangeText = {(text) => this.setState({text})}
							value = {this.state.text}
						/>
						<TouchableOpacity style = {styles.btn} onPress = {() => this._openNative()} >
							<Text style = {styles.labelBtn}>Use Native Code</Text>
						</TouchableOpacity>

						<TouchableOpacity style = {styles.btn} onPress = {() => this._openNativeScreen()} >
							<Text style = {styles.labelBtn}>Open Native Screen</Text>
						</TouchableOpacity>
					</View>
				}
		  </View>
    	);
  	}
}

const styles = StyleSheet.create({
	container: {
	  	flex: 1,
	  	backgroundColor: '#4286f4',
	  	justifyContent: 'center',
	},
	input : {
	  	height : 40,
	  	backgroundColor : '#FFFFFF',
		margin : 15,
		justifyContent : 'center',
		paddingLeft: 10,
	  	borderRadius : 10
	},
	btn : {
	  	backgroundColor : '#FFFFFF',
	  	height : 40,
	  	borderRadius : 10,
	  	margin : 15,
	  	justifyContent : 'center',
	  	alignItems : 'center'
	},
	labelBtn : {
	  	fontSize : 16
	},
	videoContainer : {
		justifyContent : 'center',
		flex : 1,
	},
	videoBox : {
		justifyContent : 'center', 
		alignItems : 'center'
	},
	iconClose : {
		flex : .1,
		alignItems : 'flex-end',
		padding : 20
	}
});
  