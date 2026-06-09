.class public Lchat/ola/vn/entity/af;
.super Ljava/lang/Object;


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/String;

.field private c:I


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/entity/af;->a:Ljava/lang/String;

    iput-object p2, p0, Lchat/ola/vn/entity/af;->b:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entity/af;->b:Ljava/lang/String;

    const-string v1, "mariage diary"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->e:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const v0, 0x7f0f06cb

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "@"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v4, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-object v4, v4, Lchat/ola/vn/entity/ag;->e:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-static {v0, v1}, Lchat/ola/vn/OlaApplication;->a(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entity/af;->a:Ljava/lang/String;

    return-object v0
.end method

.method public a(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/af;->c:I

    return-void
.end method

.method public b()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/af;->b:Ljava/lang/String;

    return-object v0
.end method

.method public c()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/af;->c:I

    return v0
.end method
