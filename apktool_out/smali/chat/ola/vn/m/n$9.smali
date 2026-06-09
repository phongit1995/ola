.class Lchat/ola/vn/m/n$9;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/n;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/n;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/n;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/n$9;->a:Lchat/ola/vn/m/n;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/n$9;->a:Lchat/ola/vn/m/n;

    invoke-static {p1}, Lchat/ola/vn/m/n;->a(Lchat/ola/vn/m/n;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->requestFocus()Z

    iget-object p1, p0, Lchat/ola/vn/m/n$9;->a:Lchat/ola/vn/m/n;

    invoke-virtual {p1}, Lchat/ola/vn/m/n;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/m/n$9;->a:Lchat/ola/vn/m/n;

    invoke-static {v0}, Lchat/ola/vn/m/n;->a(Lchat/ola/vn/m/n;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    move-result-object v0

    const/4 v1, 0x1

    invoke-static {p1, v0, v1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
