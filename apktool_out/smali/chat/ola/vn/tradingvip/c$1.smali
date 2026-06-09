.class Lchat/ola/vn/tradingvip/c$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;


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

    iput-object p1, p0, Lchat/ola/vn/tradingvip/c$1;->a:Lchat/ola/vn/tradingvip/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public b_(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/tradingvip/c$1;->a:Lchat/ola/vn/tradingvip/c;

    invoke-static {v0}, Lchat/ola/vn/tradingvip/c;->a(Lchat/ola/vn/tradingvip/c;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    move-result-object v0

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/tradingvip/c$1;->a:Lchat/ola/vn/tradingvip/c;

    invoke-static {v0}, Lchat/ola/vn/tradingvip/c;->a(Lchat/ola/vn/tradingvip/c;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setSelection(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
