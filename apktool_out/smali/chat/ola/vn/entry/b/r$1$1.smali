.class Lchat/ola/vn/entry/b/r$1$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/c;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/r$1;->a(Lchat/ola/vn/entity/u;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/r$1;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/r$1;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/r$1$1;->a:Lchat/ola/vn/entry/b/r$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(J)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/r$1$1;->a:Lchat/ola/vn/entry/b/r$1;

    iget-object v0, v0, Lchat/ola/vn/entry/b/r$1;->a:Lchat/ola/vn/entry/b/r;

    iget-object v0, v0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {v0}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entity/u;->a()J

    move-result-wide v0

    cmp-long v2, p1, v0

    if-nez v2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/entry/b/r$1$1;->a:Lchat/ola/vn/entry/b/r$1;

    iget-object p1, p1, Lchat/ola/vn/entry/b/r$1;->a:Lchat/ola/vn/entry/b/r;

    invoke-static {p1}, Lchat/ola/vn/entry/b/r;->b(Lchat/ola/vn/entry/b/r;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method

.method public a(JLchat/ola/vn/entity/f;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/r$1$1;->a:Lchat/ola/vn/entry/b/r$1;

    iget-object v0, v0, Lchat/ola/vn/entry/b/r$1;->a:Lchat/ola/vn/entry/b/r;

    iget-object v0, v0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {v0}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entity/u;->a()J

    move-result-wide v0

    cmp-long v2, p1, v0

    if-nez v2, :cond_0

    if-eqz p3, :cond_0

    iget-object p1, p0, Lchat/ola/vn/entry/b/r$1$1;->a:Lchat/ola/vn/entry/b/r$1;

    iget-object p1, p1, Lchat/ola/vn/entry/b/r$1;->a:Lchat/ola/vn/entry/b/r;

    iget-object p1, p1, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {p1}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object p1

    invoke-virtual {p1, p3}, Lchat/ola/vn/entity/u;->a(Lchat/ola/vn/entity/f;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/r$1$1;->a:Lchat/ola/vn/entry/b/r$1;

    iget-object p1, p1, Lchat/ola/vn/entry/b/r$1;->a:Lchat/ola/vn/entry/b/r;

    invoke-static {p1}, Lchat/ola/vn/entry/b/r;->b(Lchat/ola/vn/entry/b/r;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
