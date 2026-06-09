.class Lchat/ola/vn/signup/fb/a$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/network/c;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/signup/fb/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/fb/a;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/fb/a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/fb/a$1;->a:Lchat/ola/vn/signup/fb/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;Z)V
    .locals 0

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public a(S)V
    .locals 0

    return-void
.end method

.method public b()V
    .locals 0

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_2

    invoke-static {p1}, Lchat/ola/vn/h;->d(Ljava/lang/String;)V

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {p2}, Lchat/ola/vn/h;->b(Ljava/lang/String;)V

    :cond_0
    invoke-static {p3}, Lchat/ola/vn/h;->c(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0, p1}, Lchat/ola/vn/e;->a(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0, p3}, Lchat/ola/vn/e;->b(Ljava/lang/String;)V

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {v0, p1, p2, p3, v1}, Lchat/ola/vn/h/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    :cond_1
    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p2, p1}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/a$1;->a:Lchat/ola/vn/signup/fb/a;

    const-class p2, Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-virtual {p1, p2}, Lchat/ola/vn/signup/fb/a;->a(Ljava/lang/Class;)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/a$1;->a:Lchat/ola/vn/signup/fb/a;

    invoke-virtual {p1}, Lchat/ola/vn/signup/fb/a;->v()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method public b(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public b(S)V
    .locals 0

    return-void
.end method

.method public c()V
    .locals 0

    return-void
.end method

.method public d()V
    .locals 0

    return-void
.end method
