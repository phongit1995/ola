.class Lchat/ola/vn/m/y$7;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/y;->onRefresh()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/y;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/y;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/y$7;->a:Lchat/ola/vn/m/y;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/m/y$7;->a:Lchat/ola/vn/m/y;

    invoke-virtual {v0}, Lchat/ola/vn/m/y;->d()V

    iget-object v0, p0, Lchat/ola/vn/m/y$7;->a:Lchat/ola/vn/m/y;

    invoke-static {v0}, Lchat/ola/vn/m/y;->f(Lchat/ola/vn/m/y;)V

    iget-object v0, p0, Lchat/ola/vn/m/y$7;->a:Lchat/ola/vn/m/y;

    invoke-static {v0}, Lchat/ola/vn/m/y;->g(Lchat/ola/vn/m/y;)Landroid/support/v4/widget/SwipeRefreshLayout;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    return-void
.end method
