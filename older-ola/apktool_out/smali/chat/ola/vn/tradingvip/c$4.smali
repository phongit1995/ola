.class Lchat/ola/vn/tradingvip/c$4;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnKeyListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/tradingvip/c;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/tradingvip/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/tradingvip/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/tradingvip/c$4;->a:Lchat/ola/vn/tradingvip/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onKey(Landroid/view/View;ILandroid/view/KeyEvent;)Z
    .locals 0

    const/16 p1, 0x42

    if-ne p2, p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/tradingvip/c$4;->a:Lchat/ola/vn/tradingvip/c;

    invoke-static {p1}, Lchat/ola/vn/tradingvip/c;->c(Lchat/ola/vn/tradingvip/c;)V

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method
