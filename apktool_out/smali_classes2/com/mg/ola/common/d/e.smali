.class public Lcom/mg/ola/common/d/e;
.super Ljava/lang/Object;


# static fields
.field public static final a:C


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-char v0, Ljava/io/File;->separatorChar:C

    sput-char v0, Lcom/mg/ola/common/d/e;->a:C

    return-void
.end method

.method public static a(Ljava/io/InputStream;Ljava/io/OutputStream;)I
    .locals 3

    invoke-static {p0, p1}, Lcom/mg/ola/common/d/e;->b(Ljava/io/InputStream;Ljava/io/OutputStream;)J

    move-result-wide p0

    const-wide/32 v0, 0x7fffffff

    cmp-long v2, p0, v0

    if-lez v2, :cond_0

    const/4 p0, -0x1

    return p0

    :cond_0
    long-to-int p0, p0

    return p0
.end method

.method public static a(Ljava/io/Reader;Ljava/io/Writer;)I
    .locals 3

    invoke-static {p0, p1}, Lcom/mg/ola/common/d/e;->b(Ljava/io/Reader;Ljava/io/Writer;)J

    move-result-wide p0

    const-wide/32 v0, 0x7fffffff

    cmp-long v2, p0, v0

    if-lez v2, :cond_0

    const/4 p0, -0x1

    return p0

    :cond_0
    long-to-int p0, p0

    return p0
.end method

.method public static a(Ljava/io/InputStream;Ljava/io/OutputStream;[B)J
    .locals 6

    const-wide/16 v0, 0x0

    :goto_0
    const/4 v2, -0x1

    invoke-virtual {p0, p2}, Ljava/io/InputStream;->read([B)I

    move-result v3

    if-eq v2, v3, :cond_0

    const/4 v2, 0x0

    invoke-virtual {p1, p2, v2, v3}, Ljava/io/OutputStream;->write([BII)V

    int-to-long v2, v3

    add-long v4, v0, v2

    move-wide v0, v4

    goto :goto_0

    :cond_0
    return-wide v0
.end method

.method public static a(Ljava/io/Reader;Ljava/io/Writer;[C)J
    .locals 6

    const-wide/16 v0, 0x0

    :goto_0
    const/4 v2, -0x1

    invoke-virtual {p0, p2}, Ljava/io/Reader;->read([C)I

    move-result v3

    if-eq v2, v3, :cond_0

    const/4 v2, 0x0

    invoke-virtual {p1, p2, v2, v3}, Ljava/io/Writer;->write([CII)V

    int-to-long v2, v3

    add-long v4, v0, v2

    move-wide v0, v4

    goto :goto_0

    :cond_0
    return-wide v0
.end method

.method public static a(Ljava/io/InputStream;Ljava/nio/charset/Charset;)Ljava/lang/String;
    .locals 1

    new-instance v0, Ljava/io/StringWriter;

    invoke-direct {v0}, Ljava/io/StringWriter;-><init>()V

    invoke-static {p0, v0, p1}, Lcom/mg/ola/common/d/e;->a(Ljava/io/InputStream;Ljava/io/Writer;Ljava/nio/charset/Charset;)V

    invoke-virtual {v0}, Ljava/io/StringWriter;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static a(Ljava/io/Closeable;)V
    .locals 0

    if-eqz p0, :cond_0

    :try_start_0
    invoke-interface {p0}, Ljava/io/Closeable;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public static a(Ljava/io/InputStream;)V
    .locals 0

    invoke-static {p0}, Lcom/mg/ola/common/d/e;->a(Ljava/io/Closeable;)V

    return-void
.end method

.method public static a(Ljava/io/InputStream;Ljava/io/Writer;Ljava/nio/charset/Charset;)V
    .locals 1

    new-instance v0, Ljava/io/InputStreamReader;

    invoke-static {p2}, Lcom/mg/ola/common/d/a;->a(Ljava/nio/charset/Charset;)Ljava/nio/charset/Charset;

    move-result-object p2

    invoke-direct {v0, p0, p2}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/nio/charset/Charset;)V

    invoke-static {v0, p1}, Lcom/mg/ola/common/d/e;->a(Ljava/io/Reader;Ljava/io/Writer;)I

    return-void
.end method

.method public static a(Ljava/io/OutputStream;)V
    .locals 0

    invoke-static {p0}, Lcom/mg/ola/common/d/e;->a(Ljava/io/Closeable;)V

    return-void
.end method

.method public static a(Ljava/io/InputStream;I)[B
    .locals 4

    if-gez p1, :cond_0

    new-instance p0, Ljava/lang/IllegalArgumentException;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Size must be equal or greater than zero: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_0
    const/4 v0, 0x0

    if-nez p1, :cond_1

    new-array p0, v0, [B

    return-object p0

    :cond_1
    new-array v1, p1, [B

    :goto_0
    if-ge v0, p1, :cond_2

    sub-int v2, p1, v0

    invoke-virtual {p0, v1, v0, v2}, Ljava/io/InputStream;->read([BII)I

    move-result v2

    const/4 v3, -0x1

    if-eq v2, v3, :cond_2

    add-int/2addr v0, v2

    goto :goto_0

    :cond_2
    if-eq v0, p1, :cond_3

    new-instance p0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unexpected readed size. current: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, ", excepted: "

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_3
    return-object v1
.end method

.method public static a(Ljava/io/InputStream;J)[B
    .locals 3

    const-wide/32 v0, 0x7fffffff

    cmp-long v2, p1, v0

    if-lez v2, :cond_0

    new-instance p0, Ljava/lang/IllegalArgumentException;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Size cannot be greater than Integer max value: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_0
    long-to-int p1, p1

    invoke-static {p0, p1}, Lcom/mg/ola/common/d/e;->a(Ljava/io/InputStream;I)[B

    move-result-object p0

    return-object p0
.end method

.method public static b(Ljava/io/InputStream;Ljava/io/OutputStream;)J
    .locals 1

    const/16 v0, 0x1000

    new-array v0, v0, [B

    invoke-static {p0, p1, v0}, Lcom/mg/ola/common/d/e;->a(Ljava/io/InputStream;Ljava/io/OutputStream;[B)J

    move-result-wide p0

    return-wide p0
.end method

.method public static b(Ljava/io/Reader;Ljava/io/Writer;)J
    .locals 1

    const/16 v0, 0x1000

    new-array v0, v0, [C

    invoke-static {p0, p1, v0}, Lcom/mg/ola/common/d/e;->a(Ljava/io/Reader;Ljava/io/Writer;[C)J

    move-result-wide p0

    return-wide p0
.end method

.method public static b(Ljava/io/InputStream;)[B
    .locals 1

    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    invoke-static {p0, v0}, Lcom/mg/ola/common/d/e;->a(Ljava/io/InputStream;Ljava/io/OutputStream;)I

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p0

    return-object p0
.end method
