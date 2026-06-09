.class Lchat/ola/vn/m/y$5;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/y;->a(Lchat/ola/vn/entry/b/k;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/k;

.field final synthetic b:Ljava/util/List;

.field final synthetic c:Lchat/ola/vn/m/y;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/y;Lchat/ola/vn/entry/b/k;Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/y$5;->c:Lchat/ola/vn/m/y;

    iput-object p2, p0, Lchat/ola/vn/m/y$5;->a:Lchat/ola/vn/entry/b/k;

    iput-object p3, p0, Lchat/ola/vn/m/y$5;->b:Ljava/util/List;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/y$5;->a:Lchat/ola/vn/entry/b/k;

    iget-object p1, p1, Lchat/ola/vn/entry/b/k;->a:Lcom/mg/ola/common/widget/OlaTextView;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/OlaTextView;->getText()Ljava/lang/CharSequence;

    move-result-object p1

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/m/y$5;->b:Ljava/util/List;

    invoke-interface {p2, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/lang/String;

    iget-object p3, p0, Lchat/ola/vn/m/y$5;->c:Lchat/ola/vn/m/y;

    const p4, 0x7f0f0491

    invoke-virtual {p3, p4}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object p3

    invoke-static {p2, p3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p3

    if-eqz p3, :cond_0

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_3

    iget-object p2, p0, Lchat/ola/vn/m/y$5;->c:Lchat/ola/vn/m/y;

    :goto_0
    invoke-virtual {p2}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object p3, p0, Lchat/ola/vn/m/y$5;->c:Lchat/ola/vn/m/y;

    const p4, 0x7f0f0493

    invoke-virtual {p3, p4}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object p3

    invoke-static {p2, p3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p3

    if-eqz p3, :cond_2

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_3

    iget-object p2, p0, Lchat/ola/vn/m/y$5;->c:Lchat/ola/vn/m/y;

    invoke-virtual {p2}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-eqz p3, :cond_1

    goto :goto_1

    :cond_1
    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, "\n"

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :goto_1
    iget-object p2, p0, Lchat/ola/vn/m/y$5;->c:Lchat/ola/vn/m/y;

    goto :goto_0

    :cond_2
    iget-object p3, p0, Lchat/ola/vn/m/y$5;->c:Lchat/ola/vn/m/y;

    const p4, 0x7f0f00fa

    invoke-virtual {p3, p4}, Lchat/ola/vn/m/y;->getString(I)Ljava/lang/String;

    move-result-object p3

    invoke-static {p2, p3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_3

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_3

    iget-object p2, p0, Lchat/ola/vn/m/y$5;->c:Lchat/ola/vn/m/y;

    invoke-virtual {p2}, Lchat/ola/vn/m/y;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/m/z;->a(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    return-void
.end method
