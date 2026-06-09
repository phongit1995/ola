.class public Lchat/ola/vn/o/e;
.super Lchat/ola/vn/entry/e;


# instance fields
.field private m:Lchat/ola/vn/entity/k;

.field private n:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 2

    const v0, 0x7f0f00e8

    const v1, 0x7f080069

    invoke-direct {p0, v0, v1, v0}, Lchat/ola/vn/entry/e;-><init>(III)V

    const-string v0, "MicroGame Studio"

    iput-object v0, p0, Lchat/ola/vn/o/e;->n:Ljava/lang/String;

    const-string v0, "gamestore.ola.vn"

    iput-object v0, p0, Lchat/ola/vn/o/e;->h:Ljava/lang/String;

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/o/e;->i:I

    const/4 v0, 0x1

    iput v0, p0, Lchat/ola/vn/o/e;->g:I

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/k;)V
    .locals 1

    iput-object p1, p0, Lchat/ola/vn/o/e;->m:Lchat/ola/vn/entity/k;

    if-eqz p1, :cond_0

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/o/e;->f:I

    iput v0, p0, Lchat/ola/vn/o/e;->b:I

    iget-object v0, p1, Lchat/ola/vn/entity/k;->a:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/o/e;->d:Ljava/lang/String;

    iget-object v0, p1, Lchat/ola/vn/entity/k;->f:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/o/e;->e:Ljava/lang/String;

    iget-object p1, p1, Lchat/ola/vn/entity/k;->j:Ljava/lang/String;

    iput-object p1, p0, Lchat/ola/vn/o/e;->c:Ljava/lang/String;

    const/4 p1, 0x2

    iput p1, p0, Lchat/ola/vn/o/e;->g:I

    const p1, 0x7f0f0500

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/o/e;->j:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object p1

    :goto_0
    iput-object p1, p0, Lchat/ola/vn/o/e;->k:Ljava/lang/String;

    return-void

    :cond_0
    const p1, 0x7f0f00e8

    iput p1, p0, Lchat/ola/vn/o/e;->f:I

    const p1, 0x7f080069

    iput p1, p0, Lchat/ola/vn/o/e;->b:I

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/o/e;->d:Ljava/lang/String;

    const v0, 0x7f0f036a

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/o/e;->e:Ljava/lang/String;

    iput-object p1, p0, Lchat/ola/vn/o/e;->c:Ljava/lang/String;

    const/4 v0, 0x1

    iput v0, p0, Lchat/ola/vn/o/e;->g:I

    iput-object p1, p0, Lchat/ola/vn/o/e;->j:Ljava/lang/String;

    goto :goto_0

    return-void
.end method

.method public b(Landroid/content/Context;)Z
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/o/e;->m:Lchat/ola/vn/entity/k;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/o/e;->m:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->m:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/o/e;->m:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->m:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/b;->j(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/o/e;->m:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->h:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/b;->n(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/o/e;->n:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/b;->l(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    const/4 p1, 0x1

    return p1

    :catch_0
    const/4 p1, 0x0

    return p1
.end method
