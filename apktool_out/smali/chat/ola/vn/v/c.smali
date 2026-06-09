.class public Lchat/ola/vn/v/c;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/v/c$b;,
        Lchat/ola/vn/v/c$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Lchat/ola/vn/v/c$b;",
        "Ljava/lang/Void;",
        "Lchat/ola/vn/v/c$b;",
        ">;"
    }
.end annotation


# static fields
.field public static final a:[Ljava/lang/String;

.field private static b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static c:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 9

    const/16 v0, 0x8

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "User-Agent"

    const/4 v2, 0x0

    aput-object v1, v0, v2

    const-string v1, "Mozilla/5.0 (Linux; U; Android 2.2; en-us; DROID2 GLOBAL Build/S273) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1"

    const/4 v3, 0x1

    aput-object v1, v0, v3

    const-string v1, "Accept"

    const/4 v4, 0x2

    aput-object v1, v0, v4

    const-string v1, "*/*"

    const/4 v5, 0x3

    aput-object v1, v0, v5

    const-string v1, "Accept-Charset"

    const/4 v6, 0x4

    aput-object v1, v0, v6

    const-string v1, "UTF-8,*;q=0.5"

    const/4 v7, 0x5

    aput-object v1, v0, v7

    const-string v1, "Accept-Language"

    const/4 v8, 0x6

    aput-object v1, v0, v8

    const-string v1, "en-US,en;q=0.8,vi;q=0.6,fr-FR;q=0.4,fr;q=0.2"

    const/4 v8, 0x7

    aput-object v1, v0, v8

    sput-object v0, Lchat/ola/vn/v/c;->a:[Ljava/lang/String;

    new-array v0, v7, [Ljava/lang/String;

    const-string v1, "expires"

    aput-object v1, v0, v2

    const-string v1, "domain"

    aput-object v1, v0, v3

    const-string v1, "path"

    aput-object v1, v0, v4

    const-string v1, "secure"

    aput-object v1, v0, v5

    const-string v1, "httponly"

    aput-object v1, v0, v6

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/v/c;->b:Ljava/util/List;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lchat/ola/vn/v/c;->c:Ljava/util/Map;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Lchat/ola/vn/v/c$b;)Lchat/ola/vn/v/c$b;
    .locals 14
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "DefaultLocale"
        }
    .end annotation

    const/4 v0, 0x0

    aget-object p1, p1, v0

    iget-object v1, p1, Lchat/ola/vn/v/c$b;->a:Ljava/lang/String;

    iget-object v2, p1, Lchat/ola/vn/v/c$b;->b:Ljava/lang/String;

    iget-object v3, p1, Lchat/ola/vn/v/c$b;->e:[Ljava/lang/String;

    const-string v4, ""

    const/4 v5, 0x0

    :try_start_0
    new-instance v6, Ljava/net/URL;

    invoke-direct {v6, v1}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v1

    check-cast v1, Ljava/net/HttpURLConnection;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_7
    .catchall {:try_start_0 .. :try_end_0} :catchall_3

    const/4 v7, 0x1

    :try_start_1
    invoke-virtual {v1, v7}, Ljava/net/HttpURLConnection;->setInstanceFollowRedirects(Z)V

    sget-object v8, Lchat/ola/vn/v/c;->a:[Ljava/lang/String;

    array-length v8, v8

    div-int/lit8 v8, v8, 0x2

    const/4 v9, 0x0

    :goto_0
    if-ge v9, v8, :cond_0

    sget-object v10, Lchat/ola/vn/v/c;->a:[Ljava/lang/String;

    mul-int/lit8 v11, v9, 0x2

    aget-object v10, v10, v11

    sget-object v12, Lchat/ola/vn/v/c;->a:[Ljava/lang/String;

    add-int/lit8 v11, v11, 0x1

    aget-object v11, v12, v11

    invoke-virtual {v1, v10, v11}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    add-int/lit8 v9, v9, 0x1

    goto :goto_0

    :cond_0
    invoke-virtual {v6}, Ljava/net/URL;->getHost()Ljava/lang/String;

    move-result-object v6

    const-string v8, "Host"

    invoke-virtual {v1, v8, v6}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    if-eqz v3, :cond_2

    array-length v8, v3

    if-lez v8, :cond_2

    array-length v8, v3

    div-int/lit8 v8, v8, 0x2

    move-object v10, v5

    const/4 v9, 0x0

    :goto_1
    if-ge v9, v8, :cond_3

    const-string v11, "Cookie"

    mul-int/lit8 v12, v9, 0x2

    aget-object v13, v3, v12

    invoke-virtual {v11, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_1

    add-int/lit8 v12, v12, 0x1

    aget-object v10, v3, v12

    goto :goto_2

    :cond_1
    aget-object v11, v3, v12

    add-int/lit8 v12, v12, 0x1

    aget-object v12, v3, v12

    invoke-virtual {v1, v11, v12}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    :goto_2
    add-int/lit8 v9, v9, 0x1

    goto :goto_1

    :cond_2
    const-string v3, "Referer"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "http://"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v9, "/"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v1, v3, v8}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    move-object v10, v5

    :cond_3
    sget-object v3, Lchat/ola/vn/v/c;->c:Ljava/util/Map;

    invoke-interface {v3, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Map;

    if-nez v10, :cond_4

    if-eqz v3, :cond_7

    invoke-interface {v3}, Ljava/util/Map;->size()I

    move-result v8

    if-lez v8, :cond_7

    :cond_4
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    if-eqz v10, :cond_5

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_5
    if-eqz v3, :cond_6

    invoke-interface {v3}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v9

    invoke-interface {v9}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v9

    :goto_3
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v10

    if-eqz v10, :cond_6

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/util/Map$Entry;

    invoke-interface {v10}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/String;

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v11, "="

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-interface {v10}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/String;

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v10, ";"

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_3

    :cond_6
    const-string v9, "Cookie"

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v1, v9, v8}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    :cond_7
    iget-object v8, p1, Lchat/ola/vn/v/c$b;->c:Ljava/lang/String;

    if-eqz v8, :cond_8

    iget-object v8, p1, Lchat/ola/vn/v/c$b;->c:Ljava/lang/String;

    invoke-virtual {v1, v8}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    :cond_8
    iget-object v8, p1, Lchat/ola/vn/v/c$b;->d:Ljava/lang/String;

    if-nez v8, :cond_9

    const-string v8, "POST"

    iget-object v9, p1, Lchat/ola/vn/v/c$b;->c:Ljava/lang/String;

    invoke-virtual {v8, v9}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_a

    :cond_9
    invoke-virtual {v1, v7}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    iget-object v7, p1, Lchat/ola/vn/v/c$b;->d:Ljava/lang/String;

    if-eqz v7, :cond_a

    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v7
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_3
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    :try_start_2
    iget-object v8, p1, Lchat/ola/vn/v/c$b;->d:Ljava/lang/String;

    invoke-virtual {v8}, Ljava/lang/String;->getBytes()[B

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/io/OutputStream;->write([B)V

    invoke-virtual {v7}, Ljava/io/OutputStream;->flush()V

    goto :goto_4

    :cond_a
    move-object v7, v5

    :goto_4
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v8
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_8
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    :try_start_3
    const-string v5, "Set-Cookie"

    invoke-virtual {v1, v5}, Ljava/net/HttpURLConnection;->getHeaderField(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_d

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v9

    if-lez v9, :cond_d

    if-nez v3, :cond_b

    new-instance v3, Ljava/util/HashMap;

    invoke-direct {v3}, Ljava/util/HashMap;-><init>()V

    sget-object v9, Lchat/ola/vn/v/c;->c:Ljava/util/Map;

    invoke-interface {v9, v6, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_b
    const-string v6, "[;=]"

    invoke-virtual {v5, v6}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v5

    :goto_5
    array-length v6, v5

    if-ge v0, v6, :cond_d

    sget-object v6, Lchat/ola/vn/v/c;->b:Ljava/util/List;

    aget-object v9, v5, v0

    invoke-virtual {v9}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v9

    invoke-interface {v6, v9}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_c

    goto :goto_6

    :cond_c
    aget-object v6, v5, v0

    add-int/lit8 v9, v0, 0x1

    aget-object v9, v5, v9

    invoke-interface {v3, v6, v9}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    add-int/lit8 v0, v0, 0x2

    goto :goto_5

    :cond_d
    :goto_6
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->getContentEncoding()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_e

    const-string v3, "gzip"

    invoke-virtual {v0, v3}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    const/4 v3, -0x1

    if-eq v0, v3, :cond_e

    new-instance v0, Ljava/util/zip/GZIPInputStream;

    invoke-direct {v0, v8}, Ljava/util/zip/GZIPInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-object v5, v0

    goto :goto_7

    :cond_e
    move-object v5, v8

    :goto_7
    :try_start_4
    new-instance v0, Ljava/io/BufferedReader;

    new-instance v3, Ljava/io/InputStreamReader;

    sget-object v6, Lcom/mg/ola/common/d/a;->f:Ljava/nio/charset/Charset;

    invoke-direct {v3, v5, v6}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/nio/charset/Charset;)V

    invoke-direct {v0, v3}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    :goto_8
    invoke-virtual {v0}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v6

    if-eqz v6, :cond_f

    invoke-virtual {v3, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    goto :goto_8

    :cond_f
    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_8
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    :try_start_5
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_0

    :catch_0
    :try_start_6
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_1

    :catch_1
    if-eqz v7, :cond_12

    :try_start_7
    invoke-virtual {v7}, Ljava/io/OutputStream;->close()V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_c

    goto :goto_b

    :catchall_0
    move-exception p1

    move-object v5, v8

    goto :goto_9

    :catch_2
    move-object v5, v8

    goto :goto_a

    :catchall_1
    move-exception p1

    goto :goto_9

    :catchall_2
    move-exception p1

    move-object v7, v5

    goto :goto_9

    :catch_3
    move-object v7, v5

    goto :goto_a

    :catchall_3
    move-exception p1

    move-object v1, v5

    move-object v7, v1

    :goto_9
    :try_start_8
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_4

    :catch_4
    :try_start_9
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_5

    :catch_5
    if-eqz v7, :cond_10

    :try_start_a
    invoke-virtual {v7}, Ljava/io/OutputStream;->close()V
    :try_end_a
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_6

    :catch_6
    :cond_10
    throw p1

    :catch_7
    move-object v1, v5

    move-object v7, v1

    :catch_8
    :goto_a
    :try_start_b
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_b
    .catch Ljava/lang/Throwable; {:try_start_b .. :try_end_b} :catch_9

    :catch_9
    :try_start_c
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V
    :try_end_c
    .catch Ljava/lang/Throwable; {:try_start_c .. :try_end_c} :catch_a

    :catch_a
    if-eqz v7, :cond_11

    :try_start_d
    invoke-virtual {v7}, Ljava/io/OutputStream;->close()V
    :try_end_d
    .catch Ljava/lang/Throwable; {:try_start_d .. :try_end_d} :catch_b

    :catch_b
    :cond_11
    move-object v0, v4

    :catch_c
    :cond_12
    :goto_b
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "javascript:OLAPI.resultForCallback("

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ", \""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "\""

    const-string v3, "\\\""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "\")"

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p1, Lchat/ola/vn/v/c$b;->f:Ljava/lang/String;

    return-object p1
.end method

.method protected a(Lchat/ola/vn/v/c$b;)V
    .locals 1

    iget-object v0, p1, Lchat/ola/vn/v/c$b;->f:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p1, Lchat/ola/vn/v/c$b;->g:Lchat/ola/vn/v/c$a;

    if-eqz v0, :cond_0

    iget-object v0, p1, Lchat/ola/vn/v/c$b;->g:Lchat/ola/vn/v/c$a;

    iget-object p1, p1, Lchat/ola/vn/v/c$b;->f:Ljava/lang/String;

    invoke-interface {v0, p1}, Lchat/ola/vn/v/c$a;->a(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "DefaultLocale"
        }
    .end annotation

    check-cast p1, [Lchat/ola/vn/v/c$b;

    invoke-virtual {p0, p1}, Lchat/ola/vn/v/c;->a([Lchat/ola/vn/v/c$b;)Lchat/ola/vn/v/c$b;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lchat/ola/vn/v/c$b;

    invoke-virtual {p0, p1}, Lchat/ola/vn/v/c;->a(Lchat/ola/vn/v/c$b;)V

    return-void
.end method
