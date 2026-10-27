FROM golang:1.26-alpine AS builder

ENV GOTOOLCHAIN=auto

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o main ./cmd/api

FROM alpine:latest AS ffmpeg

ARG FFMPEG_VERSION=8.1.2

RUN apk add --no-cache build-base nasm pkgconf curl linux-headers perl bash xz x264-dev dav1d-dev zimg-dev

WORKDIR /src

RUN curl -fsSL "https://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.xz" | tar xJ

RUN cd "ffmpeg-${FFMPEG_VERSION}" && ./configure --prefix=/opt \
    --disable-everything --disable-autodetect --disable-doc --disable-debug \
    --disable-ffplay --disable-network --disable-avdevice \
    --enable-gpl --enable-libx264 --enable-libdav1d --enable-libzimg \
    --enable-protocol=file \
    --enable-demuxer=mov,matroska,avi,mpegts,flv,asf,mpegps,mpegvideo,ogg \
    --enable-muxer=mp4,image2 \
    --enable-decoder=h264,hevc,vp8,vp9,libdav1d,mpeg4,h263,mpeg1video,mpeg2video,wmv1,wmv2,wmv3,vc1,prores,mjpeg,theora \
    --enable-decoder=aac,mp3float,mp2float,opus,vorbis,flac,ac3,eac3,alac,amrnb,amrwb,wmav1,wmav2,pcm_s16le,pcm_s16be,pcm_s24le,pcm_s24be,pcm_f32le,pcm_u8,pcm_mulaw,pcm_alaw \
    --enable-encoder=libx264,aac,mjpeg \
    --enable-parser=h264,hevc,vp8,vp9,av1,mpeg4video,h263,mpegvideo,vc1,mjpeg,aac,mpegaudio,opus,vorbis,flac,ac3 \
    --enable-filter=scale,format,aformat,aresample,null,anull,zscale,tonemap \
 && make -j"$(nproc)" && make install && strip /opt/bin/ffmpeg /opt/bin/ffprobe

FROM alpine:latest

RUN apk --no-cache add ca-certificates tzdata x264-libs libdav1d zimg

WORKDIR /root/

COPY --from=ffmpeg /opt/bin/ffmpeg /opt/bin/ffprobe /usr/local/bin/
COPY --from=builder /app/main .
COPY --from=builder /app/docs ./docs

ENV TZ=Asia/Ho_Chi_Minh
ENV FFMPEG_PATH=/usr/local/bin/ffmpeg
ENV FFPROBE_PATH=/usr/local/bin/ffprobe

EXPOSE 8080

CMD ["./main"]
