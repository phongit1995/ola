.class Lchat/ola/vn/m/j$7;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/j;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/j;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/j;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/j$7;->a:Lchat/ola/vn/m/j;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 0

    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/m/j$7;->a:Lchat/ola/vn/m/j;

    invoke-static {p2}, Lchat/ola/vn/m/j;->a(Lchat/ola/vn/m/j;)Lchat/ola/vn/b/ag;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/b/ag;->getFilter()Landroid/widget/Filter;

    move-result-object p2

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-static {p3}, Lchat/ola/vn/util/m;->h(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Landroid/widget/Filter;->filter(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object p2, p0, Lchat/ola/vn/m/j$7;->a:Lchat/ola/vn/m/j;

    invoke-static {p2}, Lchat/ola/vn/m/j;->a(Lchat/ola/vn/m/j;)Lchat/ola/vn/b/ag;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/b/ag;->getFilter()Landroid/widget/Filter;

    move-result-object p2

    invoke-virtual {p2, p1}, Landroid/widget/Filter;->filter(Ljava/lang/CharSequence;)V

    return-void
.end method
