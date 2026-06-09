.class Lchat/ola/vn/tutorial/b$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/n/b$b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/tutorial/b;->x()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/tutorial/b;


# direct methods
.method constructor <init>(Lchat/ola/vn/tutorial/b;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/tutorial/b$1;->a:Lchat/ola/vn/tutorial/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private d()V
    .locals 2

    new-instance v0, Lchat/ola/vn/tutorial/b$1$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/tutorial/b$1$2;-><init>(Lchat/ola/vn/tutorial/b$1;)V

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v1, :cond_0

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v0

    invoke-virtual {v1, v0}, Lchat/ola/vn/network/OlaNetworkService;->b(S)V

    :cond_0
    return-void
.end method


# virtual methods
.method public a(DDF)V
    .locals 6

    new-instance p5, Lchat/ola/vn/tutorial/b$1$1;

    invoke-direct {p5, p0}, Lchat/ola/vn/tutorial/b$1$1;-><init>(Lchat/ola/vn/tutorial/b$1;)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_0

    const-wide/16 v1, -0x1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p1, p2}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const-string p1, ""

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, p3, p4}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const-string p2, ""

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {p5}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v5

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/network/OlaNetworkService;->a(JLjava/lang/String;Ljava/lang/String;S)V

    :cond_0
    return-void
.end method

.method public j_()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/tutorial/b$1;->d()V

    return-void
.end method

.method public k_()V
    .locals 0

    return-void
.end method

.method public l_()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/tutorial/b$1;->d()V

    return-void
.end method
