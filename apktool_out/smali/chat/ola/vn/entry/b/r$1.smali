.class Lchat/ola/vn/entry/b/r$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/l;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/r;->a(Lchat/ola/vn/message/r;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/r;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/r;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/r$1;->a:Lchat/ola/vn/entry/b/r;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/u;)V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/r$1;->a:Lchat/ola/vn/entry/b/r;

    iget-object v0, v0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/r;->a(Lchat/ola/vn/entity/u;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/r$1;->a:Lchat/ola/vn/entry/b/r;

    invoke-static {p1}, Lchat/ola/vn/entry/b/r;->a(Lchat/ola/vn/entry/b/r;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/r$1;->a:Lchat/ola/vn/entry/b/r;

    iget-object p1, p1, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {p1}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/entity/u;->a()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long p1, v0, v2

    if-lez p1, :cond_0

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/entry/b/r$1;->a:Lchat/ola/vn/entry/b/r;

    iget-object v0, v0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {v0}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entity/u;->a()J

    move-result-wide v0

    new-instance v2, Lchat/ola/vn/entry/b/r$1$1;

    invoke-direct {v2, p0}, Lchat/ola/vn/entry/b/r$1$1;-><init>(Lchat/ola/vn/entry/b/r$1;)V

    invoke-virtual {p1, v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->b(JLchat/ola/vn/p/c;)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/r$1;->a:Lchat/ola/vn/entry/b/r;

    invoke-static {p1}, Lchat/ola/vn/entry/b/r;->b(Lchat/ola/vn/entry/b/r;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(SLjava/lang/String;)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/r$1;->a:Lchat/ola/vn/entry/b/r;

    iget-object p1, p1, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    new-instance p2, Lchat/ola/vn/entity/u;

    invoke-direct {p2}, Lchat/ola/vn/entity/u;-><init>()V

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/r;->a(Lchat/ola/vn/entity/u;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
