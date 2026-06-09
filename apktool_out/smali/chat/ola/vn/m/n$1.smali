.class Lchat/ola/vn/m/n$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/n;->a(Landroid/view/View;Lchat/ola/vn/message/f;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/message/f;

.field final synthetic c:Lchat/ola/vn/m/n;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/n;Ljava/util/List;Lchat/ola/vn/message/f;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/n$1;->c:Lchat/ola/vn/m/n;

    iput-object p2, p0, Lchat/ola/vn/m/n$1;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/m/n$1;->b:Lchat/ola/vn/message/f;

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
    iget-object p1, p0, Lchat/ola/vn/m/n$1;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/m/n$1;->c:Lchat/ola/vn/m/n;

    const p3, 0x7f0f0463

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/n;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/n$1;->c:Lchat/ola/vn/m/n;

    invoke-virtual {p1}, Lchat/ola/vn/m/n;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/m/n$1;->b:Lchat/ola/vn/message/f;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/activity/ChangeChatGroupTopticDialog;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/m/n$1;->c:Lchat/ola/vn/m/n;

    const p3, 0x7f0f05e7

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/n;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    return-void

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/m/n$1;->c:Lchat/ola/vn/m/n;

    const p3, 0x7f0f05ce

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/n;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/m/n$1;->c:Lchat/ola/vn/m/n;

    iget-object p2, p0, Lchat/ola/vn/m/n$1;->b:Lchat/ola/vn/message/f;

    invoke-static {p1, p2}, Lchat/ola/vn/m/n;->a(Lchat/ola/vn/m/n;Lchat/ola/vn/message/f;)Lchat/ola/vn/i/f;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method
