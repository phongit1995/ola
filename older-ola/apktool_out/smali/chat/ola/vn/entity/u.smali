.class public Lchat/ola/vn/entity/u;
.super Ljava/lang/Object;


# instance fields
.field protected a:Lchat/ola/vn/entity/f;

.field protected b:Ljava/lang/String;

.field protected c:Ljava/lang/String;

.field protected d:Ljava/lang/String;

.field protected e:Ljava/lang/String;

.field protected f:Ljava/lang/String;

.field protected g:J

.field protected h:I

.field protected i:I

.field protected j:I

.field protected k:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/entity/u;->b:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/u;->c:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/u;->d:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/u;->e:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/u;->f:Ljava/lang/String;

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/entity/u;->h:I

    iput v0, p0, Lchat/ola/vn/entity/u;->i:I

    iput v0, p0, Lchat/ola/vn/entity/u;->j:I

    iput-boolean v0, p0, Lchat/ola/vn/entity/u;->k:Z

    return-void
.end method


# virtual methods
.method public a()J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/entity/u;->g:J

    return-wide v0
.end method

.method public a(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/u;->h:I

    return-void
.end method

.method public a(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/entity/u;->g:J

    return-void
.end method

.method public a(Lchat/ola/vn/entity/f;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/u;->a:Lchat/ola/vn/entity/f;

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/u;->b:Ljava/lang/String;

    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/entity/u;->k:Z

    return-void
.end method

.method public b()Lchat/ola/vn/entity/f;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/u;->a:Lchat/ola/vn/entity/f;

    return-object v0
.end method

.method public b(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/u;->i:I

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 1

    iput-object p1, p0, Lchat/ola/vn/entity/u;->c:Ljava/lang/String;

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entity/u;->c:Ljava/lang/String;

    const-string v0, ""

    invoke-static {p1, v0}, Lchat/ola/vn/util/i;->d(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/entity/u;->d:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public c()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/u;->b:Ljava/lang/String;

    return-object v0
.end method

.method public c(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/u;->j:I

    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/u;->e:Ljava/lang/String;

    return-void
.end method

.method public d()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/u;->e:Ljava/lang/String;

    return-object v0
.end method

.method public d(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/u;->f:Ljava/lang/String;

    return-void
.end method

.method public e()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/u;->h:I

    return v0
.end method

.method public f()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/u;->i:I

    return v0
.end method

.method public g()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/u;->f:Ljava/lang/String;

    return-object v0
.end method

.method public h()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/entity/u;->k:Z

    return v0
.end method

.method public i()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/u;->j:I

    return v0
.end method

.method public j()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/u;->d:Ljava/lang/String;

    return-object v0
.end method
