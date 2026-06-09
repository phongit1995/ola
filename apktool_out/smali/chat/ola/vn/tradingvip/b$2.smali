.class Lchat/ola/vn/tradingvip/b$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/tradingvip/b;->onResume()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/tradingvip/b;


# direct methods
.method constructor <init>(Lchat/ola/vn/tradingvip/b;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/tradingvip/b$2;->a:Lchat/ola/vn/tradingvip/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    invoke-static {}, Lchat/ola/vn/tradingvip/b;->v()I

    move-result v0

    if-ltz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/tradingvip/b$2;->a:Lchat/ola/vn/tradingvip/b;

    invoke-static {v0}, Lchat/ola/vn/tradingvip/b;->a(Lchat/ola/vn/tradingvip/b;)Landroid/widget/ListView;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/tradingvip/b;->v()I

    move-result v1

    invoke-static {}, Lchat/ola/vn/tradingvip/b;->x()I

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/ListView;->setSelectionFromTop(II)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/tradingvip/b$2;->a:Lchat/ola/vn/tradingvip/b;

    invoke-static {v0}, Lchat/ola/vn/tradingvip/b;->a(Lchat/ola/vn/tradingvip/b;)Landroid/widget/ListView;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setSelection(I)V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/tradingvip/b$2;->a:Lchat/ola/vn/tradingvip/b;

    invoke-static {v0}, Lchat/ola/vn/tradingvip/b;->a(Lchat/ola/vn/tradingvip/b;)Landroid/widget/ListView;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/tradingvip/b$2;->a:Lchat/ola/vn/tradingvip/b;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setOnScrollListener(Landroid/widget/AbsListView$OnScrollListener;)V

    return-void
.end method
