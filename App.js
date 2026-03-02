import React, { useState, useRef } from 'react';
import { StyleSheet, Text, View, Pressable } from 'react-native';
import { GestureHandlerRootView, GestureDetector, Gesture } from 'react-native-gesture-handler';
import { StatusBar } from 'expo-status-bar';

export default function App() {
  const [time, setTime] = useState(0);
  const [isRunning, setIsRunning] = useState(false);
  const intervalRef = useRef(null);

  const startStop = () => {
    if (isRunning) {
      clearInterval(intervalRef.current);
      setIsRunning(false);
    } else {
      setIsRunning(true);
      intervalRef.current = setInterval(() => {
        setTime(prevTime => prevTime + 10);
      }, 10);
    }
  };

  const reset = () => {
    clearInterval(intervalRef.current);
    setTime(0);
    setIsRunning(false);
  };

  const formatTime = (milliseconds) => {
    const totalSeconds = Math.floor(milliseconds / 1000);
    const minutes = Math.floor(totalSeconds / 60);
    const seconds = totalSeconds % 60;
    const ms = Math.floor((milliseconds % 1000) / 10);
    
    return `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}.${ms.toString().padStart(2, '0')}`;
  };

  // Одиночный тап - старт/пауза
  const singleTap = Gesture.Tap()
    .numberOfTaps(1)
    .onEnd(() => {
      startStop();
    });

  // Двойной тап - сброс
  const doubleTap = Gesture.Tap()
    .numberOfTaps(2)
    .onEnd(() => {
      reset();
    });

  const taps = Gesture.Exclusive(doubleTap, singleTap);

  return (
    <GestureHandlerRootView style={styles.container}>
      <StatusBar style="light" />
      <GestureDetector gesture={taps}>
        <View style={styles.touchArea}>
          <Text style={[styles.time, { color: isRunning ? '#00ff00' : '#ff0000' }]}>
            {formatTime(time)}
          </Text>
          <Text style={styles.hint}>
            Tap - Start/Pause{'\n'}
            Double Tap - Reset
          </Text>
        </View>
      </GestureDetector>
    </GestureHandlerRootView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#000',
  },
  touchArea: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  time: {
    fontSize: 72,
    fontWeight: 'bold',
    fontFamily: 'monospace',
  },
  hint: {
    marginTop: 40,
    fontSize: 16,
    color: '#666',
    textAlign: 'center',
    lineHeight: 24,
  },
});
