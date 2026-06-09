.class Lchat/ola/vn/activity/OlaChatViewActivity$15;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatViewActivity;->b(Lchat/ola/vn/message/d;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/message/d;

.field final synthetic c:Lchat/ola/vn/activity/OlaChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaChatViewActivity;Ljava/util/List;Lchat/ola/vn/message/d;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->b:Lchat/ola/vn/message/d;

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
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p3, 0x7f0f0491

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->b:Lchat/ola/vn/message/d;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_7

    :goto_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p2, p1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p3, 0x7f0f0493

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->b:Lchat/ola/vn/message/d;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_7

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-eqz p3, :cond_1

    goto :goto_0

    :cond_1
    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, " "

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p3, 0x7f0f00fa

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_3

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->b:Lchat/ola/vn/message/d;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_7

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p2, p1}, Lchat/ola/vn/m/z;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_3
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p3, 0x7f0f04a6

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_4

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    iget-object p3, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p3

    invoke-virtual {p3}, Lchat/ola/vn/message/f;->k()S

    move-result p3

    iget-object p4, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->b:Lchat/ola/vn/message/d;

    invoke-virtual {p4}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p4

    invoke-virtual {p1, p2, p3, p4}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;SLjava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->b:Lchat/ola/vn/message/d;

    invoke-virtual {p2}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/f;->l(Ljava/lang/String;)V

    return-void

    :cond_4
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p3, 0x7f0f05f4

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    const/4 p3, 0x1

    if-eqz p2, :cond_5

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    iget-object p4, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p4}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p4

    invoke-virtual {p4}, Lchat/ola/vn/message/f;->k()S

    move-result p4

    iget-object p5, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->b:Lchat/ola/vn/message/d;

    invoke-virtual {p5}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p5

    invoke-virtual {p1, p2, p4, p5}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;SLjava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->b:Lchat/ola/vn/message/d;

    iput-boolean p3, p1, Lchat/ola/vn/message/d;->w:Z

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->b:Lchat/ola/vn/message/d;

    const/4 p2, 0x0

    iput-object p2, p1, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    :goto_1
    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->l(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/b/o;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/b/o;->notifyDataSetChanged()V

    return-void

    :cond_5
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p4, 0x7f0f043d

    invoke-virtual {p2, p4}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_6

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    iget-object p4, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p4}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p4

    invoke-virtual {p4}, Lchat/ola/vn/message/f;->k()S

    move-result p4

    iget-object p5, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->b:Lchat/ola/vn/message/d;

    invoke-virtual {p5}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p5

    invoke-virtual {p1, p2, p4, p5}, Lchat/ola/vn/network/OlaNetworkService;->c(Ljava/lang/String;SLjava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->b:Lchat/ola/vn/message/d;

    iput-boolean p3, p1, Lchat/ola/vn/message/d;->x:Z

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    goto :goto_1

    :cond_6
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p3, 0x7f0f04d0

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->b:Lchat/ola/vn/message/d;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->g(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/widget/EditText;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$15;->b:Lchat/ola/vn/message/d;

    invoke-virtual {p2}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_7
    return-void
.end method
