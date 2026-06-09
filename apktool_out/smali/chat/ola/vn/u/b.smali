.class public Lchat/ola/vn/u/b;
.super Ljava/lang/Object;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale"
    }
.end annotation


# static fields
.field private static a:Lchat/ola/vn/u/b;


# direct methods
.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a()Lchat/ola/vn/u/b;
    .locals 1

    sget-object v0, Lchat/ola/vn/u/b;->a:Lchat/ola/vn/u/b;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/u/b;

    invoke-direct {v0}, Lchat/ola/vn/u/b;-><init>()V

    sput-object v0, Lchat/ola/vn/u/b;->a:Lchat/ola/vn/u/b;

    :cond_0
    sget-object v0, Lchat/ola/vn/u/b;->a:Lchat/ola/vn/u/b;

    return-object v0
.end method

.method private a(Lchat/ola/vn/u/p;)V
    .locals 7
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "DefaultLocale"
        }
    .end annotation

    invoke-virtual {p1}, Lchat/ola/vn/u/p;->a()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    :try_start_0
    new-instance v2, Ljava/io/File;

    invoke-direct {v2, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-virtual {v2}, Ljava/io/File;->length()J

    move-result-wide v2

    invoke-static {v0}, Lcom/mg/ola/common/d/d;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "Ocam"

    invoke-virtual {v4, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v5

    const/4 v6, 0x1

    if-eqz v5, :cond_0

    invoke-static {v4, v2, v3}, Lchat/ola/vn/util/o;->b(Ljava/lang/String;J)Z

    move-result v2

    xor-int/2addr v6, v2

    :cond_0
    iput-boolean v6, p1, Lchat/ola/vn/u/p;->b:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    new-instance v2, Lchat/ola/vn/u/m;

    invoke-direct {v2}, Lchat/ola/vn/u/m;-><init>()V

    invoke-virtual {v2, p1}, Lchat/ola/vn/u/m;->a(Lchat/ola/vn/u/p;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    return-void

    :catch_0
    move-exception v2

    :try_start_2
    invoke-virtual {v2}, Ljava/lang/Throwable;->printStackTrace()V

    return-void

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/u/p;->c()Lchat/ola/vn/u/o;

    move-result-object v2

    if-eqz v2, :cond_2

    invoke-virtual {p1}, Lchat/ola/vn/u/p;->c()Lchat/ola/vn/u/o;

    move-result-object v2

    invoke-interface {v2, v0, v1}, Lchat/ola/vn/u/o;->b(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    move-exception v2

    invoke-virtual {v2}, Ljava/lang/Throwable;->printStackTrace()V

    invoke-virtual {p1}, Lchat/ola/vn/u/p;->c()Lchat/ola/vn/u/o;

    move-result-object v2

    if-eqz v2, :cond_2

    invoke-virtual {p1}, Lchat/ola/vn/u/p;->c()Lchat/ola/vn/u/o;

    move-result-object p1

    invoke-interface {p1, v0, v1}, Lchat/ola/vn/u/o;->b(Ljava/lang/String;Ljava/lang/String;)V

    :cond_2
    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/u/o;)Lchat/ola/vn/u/p;
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0, p2, p3}, Lchat/ola/vn/u/b;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/u/o;)Lchat/ola/vn/u/p;

    move-result-object p1

    return-object p1
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/u/o;)Lchat/ola/vn/u/p;
    .locals 3

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/d;->f(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    new-instance p2, Lchat/ola/vn/entity/i;

    invoke-direct {p2}, Lchat/ola/vn/entity/i;-><init>()V

    invoke-virtual {p2, v0}, Lchat/ola/vn/entity/i;->a(Ljava/lang/String;)V

    invoke-virtual {p2}, Lchat/ola/vn/entity/i;->f()S

    move-result v0

    if-eqz v0, :cond_5

    if-eqz p4, :cond_1

    new-instance v0, Lchat/ola/vn/u/b$1;

    invoke-direct {v0, p0, p4, p2}, Lchat/ola/vn/u/b$1;-><init>(Lchat/ola/vn/u/b;Lchat/ola/vn/u/o;Lchat/ola/vn/entity/i;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    :cond_1
    invoke-virtual {p2}, Lchat/ola/vn/entity/i;->i()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2, p3, p4}, Lchat/ola/vn/u/p;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/u/o;)Lchat/ola/vn/u/p;

    move-result-object p1

    return-object p1

    :cond_2
    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-static {p1}, Lchat/ola/vn/util/o;->f(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    :cond_3
    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    const-string p2, "jpg"

    :cond_4
    invoke-static {p1, p2, p3, p4}, Lchat/ola/vn/u/p;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/u/o;)Lchat/ola/vn/u/p;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/u/b;->a(Lchat/ola/vn/u/p;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_5
    return-object v1
.end method

.method public a(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/u/p;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_0
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/u/p;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object v1, v0, Lchat/ola/vn/u/p;->a:Lchat/ola/vn/u/m;

    if-eqz v1, :cond_0

    iget-object v0, v0, Lchat/ola/vn/u/p;->a:Lchat/ola/vn/u/m;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/u/m;->a(Z)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    :try_start_2
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method

.method public b()V
    .locals 0

    return-void
.end method
