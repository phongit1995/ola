.class public Lchat/ola/vn/note/a;
.super Ljava/lang/Object;


# instance fields
.field protected a:Ljava/lang/String;

.field protected b:Ljava/lang/String;

.field protected c:B

.field private d:J

.field private e:I

.field private f:I

.field private g:I

.field private h:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/note/a;->a:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/note/a;->b:Ljava/lang/String;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/note/a;->d:J

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/note/a;->e:I

    iput v0, p0, Lchat/ola/vn/note/a;->f:I

    iput v0, p0, Lchat/ola/vn/note/a;->g:I

    iput-byte v0, p0, Lchat/ola/vn/note/a;->c:B

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/note/a;->d:J

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/note/a;)I
    .locals 1

    iget v0, p0, Lchat/ola/vn/note/a;->f:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lchat/ola/vn/note/a;->f:I

    return v0
.end method

.method static synthetic b(Lchat/ola/vn/note/a;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/note/a;->e:I

    return p0
.end method

.method static synthetic c(Lchat/ola/vn/note/a;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/note/a;->f:I

    return p0
.end method

.method private c()V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/note/a;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    new-instance v0, Lchat/ola/vn/note/a$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/note/a$2;-><init>(Lchat/ola/vn/note/a;)V

    iget-object v1, p0, Lchat/ola/vn/note/a;->b:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Note-"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    new-instance v2, Ljava/text/SimpleDateFormat;

    const-string v3, "dd-MM-yyyy HH:mmZ"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v4

    invoke-direct {v2, v3, v4}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v3, Ljava/util/Date;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-direct {v3, v4, v5}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v2, v3}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/note/a;->b:Ljava/lang/String;

    :cond_0
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v2, p0, Lchat/ola/vn/note/a;->b:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/note/a;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v0

    invoke-virtual {v1, v2, v3, v0}, Lchat/ola/vn/network/OlaNetworkService;->j(Ljava/lang/String;Ljava/lang/String;S)V

    iget-object v0, p0, Lchat/ola/vn/note/a;->h:Ljava/lang/Runnable;

    if-nez v0, :cond_1

    new-instance v0, Lchat/ola/vn/note/a$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/note/a$3;-><init>(Lchat/ola/vn/note/a;)V

    iput-object v0, p0, Lchat/ola/vn/note/a;->h:Ljava/lang/Runnable;

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/note/a;->h:Ljava/lang/Runnable;

    const-wide/16 v1, 0xbb8

    invoke-static {v0, v1, v2}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    :cond_2
    return-void
.end method

.method static synthetic d(Lchat/ola/vn/note/a;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/note/a;->g:I

    return p0
.end method

.method private d()V
    .locals 2

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    const v1, 0x7f0f025a

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/c/c;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic e(Lchat/ola/vn/note/a;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/note/a;->d()V

    return-void
.end method

.method static synthetic f(Lchat/ola/vn/note/a;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/note/a;->c()V

    return-void
.end method

.method static synthetic g(Lchat/ola/vn/note/a;)I
    .locals 1

    iget v0, p0, Lchat/ola/vn/note/a;->e:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lchat/ola/vn/note/a;->e:I

    return v0
.end method

.method static synthetic h(Lchat/ola/vn/note/a;)Ljava/lang/Runnable;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/note/a;->h:Ljava/lang/Runnable;

    return-object p0
.end method


# virtual methods
.method public a()Lorg/json/JSONObject;
    .locals 4

    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "meDraftId"

    iget-wide v2, p0, Lchat/ola/vn/note/a;->d:J

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    const-string v1, "state"

    iget-byte v2, p0, Lchat/ola/vn/note/a;->c:B

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    iget-object v1, p0, Lchat/ola/vn/note/a;->a:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "text"

    iget-object v2, p0, Lchat/ola/vn/note/a;->a:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public b()V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/note/a;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/i;->c(Ljava/lang/CharSequence;)Ljava/util/ArrayList;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    if-lez v2, :cond_0

    :try_start_0
    iput v1, p0, Lchat/ola/vn/note/a;->f:I

    iput v1, p0, Lchat/ola/vn/note/a;->e:I

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    iput v2, p0, Lchat/ola/vn/note/a;->g:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v1, 0x1

    :catch_0
    :cond_0
    if-eqz v1, :cond_3

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :catch_1
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    const/4 v2, 0x0

    :try_start_1
    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, ":"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    :cond_1
    const-string v3, "file://"

    invoke-virtual {v1, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    const-string v3, "file://"

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {v1, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    const-string v4, "UTF-8"

    invoke-static {v3, v4}, Ljava/net/URLDecoder;->decode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    :cond_2
    move-object v3, v1

    :goto_1
    invoke-static {}, Lchat/ola/vn/u/b;->a()Lchat/ola/vn/u/b;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/note/a$1;

    invoke-direct {v5, p0, v1}, Lchat/ola/vn/note/a$1;-><init>(Lchat/ola/vn/note/a;Ljava/lang/String;)V

    invoke-virtual {v4, v3, v2, v5}, Lchat/ola/vn/u/b;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/u/o;)Lchat/ola/vn/u/p;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :cond_3
    invoke-direct {p0}, Lchat/ola/vn/note/a;->c()V

    :cond_4
    return-void
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5

    :try_start_0
    iget-wide v0, p0, Lchat/ola/vn/note/a;->d:J

    move-object v2, p1

    check-cast v2, Lchat/ola/vn/note/a;

    iget-wide v2, v2, Lchat/ola/vn/note/a;->d:J
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    cmp-long v4, v0, v2

    if-nez v4, :cond_0

    const/4 p1, 0x1

    return p1

    :catch_0
    :cond_0
    invoke-super {p0, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/note/a;->a()Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method
