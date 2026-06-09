.class Lchat/ola/vn/m/x$7;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/x;->onRefresh()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/x;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/x;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/x$7;->a:Lchat/ola/vn/m/x;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/m/x$7;->a:Lchat/ola/vn/m/x;

    invoke-virtual {v0}, Lchat/ola/vn/m/x;->d()V

    iget-object v0, p0, Lchat/ola/vn/m/x$7;->a:Lchat/ola/vn/m/x;

    invoke-static {v0}, Lchat/ola/vn/m/x;->d(Lchat/ola/vn/m/x;)V

    iget-object v0, p0, Lchat/ola/vn/m/x$7;->a:Lchat/ola/vn/m/x;

    invoke-static {v0}, Lchat/ola/vn/m/x;->e(Lchat/ola/vn/m/x;)Landroid/support/v4/widget/SwipeRefreshLayout;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    return-void
.end method
