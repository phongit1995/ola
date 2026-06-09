package com.google.android.gms.internal.measurement;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.SocketAddress;
import java.nio.channels.SocketChannel;
import java.util.ArrayList;
import java.util.Arrays;
import javax.net.ssl.HandshakeCompletedListener;
import javax.net.ssl.SSLSession;
import javax.net.ssl.SSLSocket;

/* JADX INFO: loaded from: classes2.dex */
final class zzkf extends SSLSocket {
    private final SSLSocket zzatc;

    zzkf(zzke zzkeVar, SSLSocket sSLSocket) {
        this.zzatc = sSLSocket;
    }

    @Override // javax.net.ssl.SSLSocket
    public final void addHandshakeCompletedListener(HandshakeCompletedListener handshakeCompletedListener) {
        this.zzatc.addHandshakeCompletedListener(handshakeCompletedListener);
    }

    @Override // java.net.Socket
    public final void bind(SocketAddress socketAddress) {
        this.zzatc.bind(socketAddress);
    }

    @Override // java.net.Socket, java.io.Closeable, java.lang.AutoCloseable
    public final synchronized void close() {
        this.zzatc.close();
    }

    @Override // java.net.Socket
    public final void connect(SocketAddress socketAddress) {
        this.zzatc.connect(socketAddress);
    }

    @Override // java.net.Socket
    public final void connect(SocketAddress socketAddress, int i) {
        this.zzatc.connect(socketAddress, i);
    }

    public final boolean equals(Object obj) {
        return this.zzatc.equals(obj);
    }

    @Override // java.net.Socket
    public final SocketChannel getChannel() {
        return this.zzatc.getChannel();
    }

    @Override // javax.net.ssl.SSLSocket
    public final boolean getEnableSessionCreation() {
        return this.zzatc.getEnableSessionCreation();
    }

    @Override // javax.net.ssl.SSLSocket
    public final String[] getEnabledCipherSuites() {
        return this.zzatc.getEnabledCipherSuites();
    }

    @Override // javax.net.ssl.SSLSocket
    public final String[] getEnabledProtocols() {
        return this.zzatc.getEnabledProtocols();
    }

    @Override // java.net.Socket
    public final InetAddress getInetAddress() {
        return this.zzatc.getInetAddress();
    }

    @Override // java.net.Socket
    public final InputStream getInputStream() {
        return this.zzatc.getInputStream();
    }

    @Override // java.net.Socket
    public final boolean getKeepAlive() {
        return this.zzatc.getKeepAlive();
    }

    @Override // java.net.Socket
    public final InetAddress getLocalAddress() {
        return this.zzatc.getLocalAddress();
    }

    @Override // java.net.Socket
    public final int getLocalPort() {
        return this.zzatc.getLocalPort();
    }

    @Override // java.net.Socket
    public final SocketAddress getLocalSocketAddress() {
        return this.zzatc.getLocalSocketAddress();
    }

    @Override // javax.net.ssl.SSLSocket
    public final boolean getNeedClientAuth() {
        return this.zzatc.getNeedClientAuth();
    }

    @Override // java.net.Socket
    public final boolean getOOBInline() {
        return this.zzatc.getOOBInline();
    }

    @Override // java.net.Socket
    public final OutputStream getOutputStream() {
        return this.zzatc.getOutputStream();
    }

    @Override // java.net.Socket
    public final int getPort() {
        return this.zzatc.getPort();
    }

    @Override // java.net.Socket
    public final synchronized int getReceiveBufferSize() {
        return this.zzatc.getReceiveBufferSize();
    }

    @Override // java.net.Socket
    public final SocketAddress getRemoteSocketAddress() {
        return this.zzatc.getRemoteSocketAddress();
    }

    @Override // java.net.Socket
    public final boolean getReuseAddress() {
        return this.zzatc.getReuseAddress();
    }

    @Override // java.net.Socket
    public final synchronized int getSendBufferSize() {
        return this.zzatc.getSendBufferSize();
    }

    @Override // javax.net.ssl.SSLSocket
    public final SSLSession getSession() {
        return this.zzatc.getSession();
    }

    @Override // java.net.Socket
    public final int getSoLinger() {
        return this.zzatc.getSoLinger();
    }

    @Override // java.net.Socket
    public final synchronized int getSoTimeout() {
        return this.zzatc.getSoTimeout();
    }

    @Override // javax.net.ssl.SSLSocket
    public final String[] getSupportedCipherSuites() {
        return this.zzatc.getSupportedCipherSuites();
    }

    @Override // javax.net.ssl.SSLSocket
    public final String[] getSupportedProtocols() {
        return this.zzatc.getSupportedProtocols();
    }

    @Override // java.net.Socket
    public final boolean getTcpNoDelay() {
        return this.zzatc.getTcpNoDelay();
    }

    @Override // java.net.Socket
    public final int getTrafficClass() {
        return this.zzatc.getTrafficClass();
    }

    @Override // javax.net.ssl.SSLSocket
    public final boolean getUseClientMode() {
        return this.zzatc.getUseClientMode();
    }

    @Override // javax.net.ssl.SSLSocket
    public final boolean getWantClientAuth() {
        return this.zzatc.getWantClientAuth();
    }

    @Override // java.net.Socket
    public final boolean isBound() {
        return this.zzatc.isBound();
    }

    @Override // java.net.Socket
    public final boolean isClosed() {
        return this.zzatc.isClosed();
    }

    @Override // java.net.Socket
    public final boolean isConnected() {
        return this.zzatc.isConnected();
    }

    @Override // java.net.Socket
    public final boolean isInputShutdown() {
        return this.zzatc.isInputShutdown();
    }

    @Override // java.net.Socket
    public final boolean isOutputShutdown() {
        return this.zzatc.isOutputShutdown();
    }

    @Override // javax.net.ssl.SSLSocket
    public final void removeHandshakeCompletedListener(HandshakeCompletedListener handshakeCompletedListener) {
        this.zzatc.removeHandshakeCompletedListener(handshakeCompletedListener);
    }

    @Override // java.net.Socket
    public final void sendUrgentData(int i) {
        this.zzatc.sendUrgentData(i);
    }

    @Override // javax.net.ssl.SSLSocket
    public final void setEnableSessionCreation(boolean z) {
        this.zzatc.setEnableSessionCreation(z);
    }

    @Override // javax.net.ssl.SSLSocket
    public final void setEnabledCipherSuites(String[] strArr) {
        this.zzatc.setEnabledCipherSuites(strArr);
    }

    @Override // javax.net.ssl.SSLSocket
    public final void setEnabledProtocols(String[] strArr) {
        if (strArr != null && Arrays.asList(strArr).contains("SSLv3")) {
            ArrayList arrayList = new ArrayList(Arrays.asList(this.zzatc.getEnabledProtocols()));
            if (arrayList.size() > 1) {
                arrayList.remove("SSLv3");
            }
            strArr = (String[]) arrayList.toArray(new String[arrayList.size()]);
        }
        this.zzatc.setEnabledProtocols(strArr);
    }

    @Override // java.net.Socket
    public final void setKeepAlive(boolean z) {
        this.zzatc.setKeepAlive(z);
    }

    @Override // javax.net.ssl.SSLSocket
    public final void setNeedClientAuth(boolean z) {
        this.zzatc.setNeedClientAuth(z);
    }

    @Override // java.net.Socket
    public final void setOOBInline(boolean z) {
        this.zzatc.setOOBInline(z);
    }

    @Override // java.net.Socket
    public final void setPerformancePreferences(int i, int i2, int i3) {
        this.zzatc.setPerformancePreferences(i, i2, i3);
    }

    @Override // java.net.Socket
    public final synchronized void setReceiveBufferSize(int i) {
        this.zzatc.setReceiveBufferSize(i);
    }

    @Override // java.net.Socket
    public final void setReuseAddress(boolean z) {
        this.zzatc.setReuseAddress(z);
    }

    @Override // java.net.Socket
    public final synchronized void setSendBufferSize(int i) {
        this.zzatc.setSendBufferSize(i);
    }

    @Override // java.net.Socket
    public final void setSoLinger(boolean z, int i) {
        this.zzatc.setSoLinger(z, i);
    }

    @Override // java.net.Socket
    public final synchronized void setSoTimeout(int i) {
        this.zzatc.setSoTimeout(i);
    }

    @Override // java.net.Socket
    public final void setTcpNoDelay(boolean z) {
        this.zzatc.setTcpNoDelay(z);
    }

    @Override // java.net.Socket
    public final void setTrafficClass(int i) {
        this.zzatc.setTrafficClass(i);
    }

    @Override // javax.net.ssl.SSLSocket
    public final void setUseClientMode(boolean z) {
        this.zzatc.setUseClientMode(z);
    }

    @Override // javax.net.ssl.SSLSocket
    public final void setWantClientAuth(boolean z) {
        this.zzatc.setWantClientAuth(z);
    }

    @Override // java.net.Socket
    public final void shutdownInput() {
        this.zzatc.shutdownInput();
    }

    @Override // java.net.Socket
    public final void shutdownOutput() {
        this.zzatc.shutdownOutput();
    }

    @Override // javax.net.ssl.SSLSocket
    public final void startHandshake() throws IOException {
        this.zzatc.startHandshake();
    }

    @Override // javax.net.ssl.SSLSocket, java.net.Socket
    public final String toString() {
        return this.zzatc.toString();
    }
}
