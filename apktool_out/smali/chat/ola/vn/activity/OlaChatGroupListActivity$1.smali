.class Lchat/ola/vn/activity/OlaChatGroupListActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatGroupListActivity;->onItemLongClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/message/f;

.field final synthetic c:Lchat/ola/vn/activity/OlaChatGroupListActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaChatGroupListActivity;Ljava/util/List;Lchat/ola/vn/message/f;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity$1;->c:Lchat/ola/vn/activity/OlaChatGroupListActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity$1;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity$1;->b:Lchat/ola/vn/message/f;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 6
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
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity$1;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity$1;->c:Lchat/ola/vn/activity/OlaChatGroupListActivity;

    const p3, 0x7f0f0453

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatGroupListActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity$1;->c:Lchat/ola/vn/activity/OlaChatGroupListActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity$1;->c:Lchat/ola/vn/activity/OlaChatGroupListActivity;

    iget-object p3, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity$1;->b:Lchat/ola/vn/message/f;

    invoke-static {p1, p2, p3}, Lchat/ola/vn/activity/OlaChatGroupListActivity;->a(Lchat/ola/vn/activity/OlaChatGroupListActivity;Landroid/content/Context;Lchat/ola/vn/message/f;)V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity$1;->c:Lchat/ola/vn/activity/OlaChatGroupListActivity;

    const p3, 0x7f0f04a6

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatGroupListActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity$1;->c:Lchat/ola/vn/activity/OlaChatGroupListActivity;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity$1;->c:Lchat/ola/vn/activity/OlaChatGroupListActivity;

    const p2, 0x7f0f009b

    invoke-virtual {p1, p2}, Lchat/ola/vn/activity/OlaChatGroupListActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity$1;->c:Lchat/ola/vn/activity/OlaChatGroupListActivity;

    const p2, 0x7f0f04b2

    const/4 p4, 0x1

    new-array p4, p4, [Ljava/lang/Object;

    const/4 p5, 0x0

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity$1;->b:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object v2

    aput-object v2, p4, p5

    invoke-virtual {p1, p2, p4}, Lchat/ola/vn/activity/OlaChatGroupListActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity$1;->c:Lchat/ola/vn/activity/OlaChatGroupListActivity;

    invoke-virtual {p1, p3}, Lchat/ola/vn/activity/OlaChatGroupListActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity$1;->c:Lchat/ola/vn/activity/OlaChatGroupListActivity;

    const p2, 0x7f0f0577

    invoke-virtual {p1, p2}, Lchat/ola/vn/activity/OlaChatGroupListActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/activity/OlaChatGroupListActivity$1$1;

    invoke-direct {v5, p0}, Lchat/ola/vn/activity/OlaChatGroupListActivity$1$1;-><init>(Lchat/ola/vn/activity/OlaChatGroupListActivity$1;)V

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
