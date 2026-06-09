.class Lchat/ola/vn/m/v$12;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/b/j$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/v;->b(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/v;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/v;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/v$12;->a:Lchat/ola/vn/m/v;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public B()Z
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/m/v$12;->a:Lchat/ola/vn/m/v;

    iget-object v0, v0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/v$12;->a:Lchat/ola/vn/m/v;

    iget-object v0, v0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->R()I

    move-result v0

    const/4 v2, 0x1

    if-eq v0, v2, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/v$12;->a:Lchat/ola/vn/m/v;

    iget-object v0, v0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->k()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/v$12;->a:Lchat/ola/vn/m/v;

    iget-object v0, v0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->o()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    :cond_0
    return v1
.end method

.method public a_(I)V
    .locals 4

    iget-object p1, p0, Lchat/ola/vn/m/v$12;->a:Lchat/ola/vn/m/v;

    iget-object v0, p0, Lchat/ola/vn/m/v$12;->a:Lchat/ola/vn/m/v;

    iget-object v0, v0, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->B()J

    move-result-wide v0

    iget-object v2, p0, Lchat/ola/vn/m/v$12;->a:Lchat/ola/vn/m/v;

    iget-object v2, v2, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v2}, Lchat/ola/vn/entity/e;->H()J

    move-result-wide v2

    invoke-static {p1, v0, v1, v2, v3}, Lchat/ola/vn/m/v;->a(Lchat/ola/vn/m/v;JJ)V

    return-void
.end method
