.class public Lchat/ola/vn/u/p;
.super Ljava/lang/Object;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale"
    }
.end annotation


# instance fields
.field a:Lchat/ola/vn/u/m;

.field b:Z

.field private c:[B

.field private d:Ljava/lang/String;

.field private e:Ljava/lang/String;

.field private f:Ljava/lang/String;

.field private g:Ljava/lang/String;

.field private h:Lchat/ola/vn/u/o;


# direct methods
.method private constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/u/p;->b:Z

    return-void
.end method

.method public static a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/u/o;)Lchat/ola/vn/u/p;
    .locals 1

    new-instance v0, Lchat/ola/vn/u/p;

    invoke-direct {v0}, Lchat/ola/vn/u/p;-><init>()V

    iput-object p0, v0, Lchat/ola/vn/u/p;->d:Ljava/lang/String;

    iput-object p1, v0, Lchat/ola/vn/u/p;->f:Ljava/lang/String;

    iput-object p2, v0, Lchat/ola/vn/u/p;->g:Ljava/lang/String;

    iput-object p3, v0, Lchat/ola/vn/u/p;->h:Lchat/ola/vn/u/o;

    return-object v0
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/u/p;->d:Ljava/lang/String;

    return-object v0
.end method

.method public a([B)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/u/p;->c:[B

    return-void
.end method

.method public b()[B
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/u/p;->c:[B

    return-object v0
.end method

.method public c()Lchat/ola/vn/u/o;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/u/p;->h:Lchat/ola/vn/u/o;

    return-object v0
.end method

.method public d()Ljava/lang/String;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/u/p;->f:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/u/p;->f:Ljava/lang/String;

    return-object v0
.end method

.method public e()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/u/p;->e:Ljava/lang/String;

    return-object v0
.end method
