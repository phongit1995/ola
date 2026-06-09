.class Lchat/ola/vn/me/c$17;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/c;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/c$17;->a:Lchat/ola/vn/me/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public b_(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    const-string v0, "#"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/c$17;->a:Lchat/ola/vn/me/c;

    invoke-virtual {v0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v0, v1, p1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/me/c$17;->a:Lchat/ola/vn/me/c;

    invoke-static {p1}, Lchat/ola/vn/me/c;->f(Lchat/ola/vn/me/c;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    move-result-object p1

    const-string v0, ""

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/me/c$17;->a:Lchat/ola/vn/me/c;

    invoke-virtual {p1}, Lchat/ola/vn/me/c;->e()V

    iget-object p1, p0, Lchat/ola/vn/me/c$17;->a:Lchat/ola/vn/me/c;

    invoke-static {p1}, Lchat/ola/vn/me/c;->a(Lchat/ola/vn/me/c;)Lchat/ola/vn/me/b;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/me/b;->notifyDataSetChanged()V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/c$17;->a:Lchat/ola/vn/me/c;

    invoke-static {v0, p1}, Lchat/ola/vn/me/c;->a(Lchat/ola/vn/me/c;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
