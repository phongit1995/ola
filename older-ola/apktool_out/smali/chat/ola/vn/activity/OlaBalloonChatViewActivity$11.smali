.class Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Lchat/ola/vn/message/d;Landroid/view/View;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/message/d;

.field final synthetic c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Ljava/util/List;Lchat/ola/vn/message/d;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->b:Lchat/ola/vn/message/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 1
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
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    if-eqz p1, :cond_7

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    const p3, 0x7f0f0491

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    const/4 p3, 0x0

    if-eqz p2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->b:Lchat/ola/vn/message/d;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->e()B

    move-result p1

    packed-switch p1, :pswitch_data_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->b:Lchat/ola/vn/message/d;

    goto :goto_0

    :pswitch_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->b:Lchat/ola/vn/message/d;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object p3

    goto :goto_1

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->b:Lchat/ola/vn/message/d;

    check-cast p1, Lchat/ola/vn/message/v;

    invoke-virtual {p1}, Lchat/ola/vn/message/v;->D()Ljava/lang/CharSequence;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p3

    goto :goto_1

    :goto_0
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->x()Z

    :cond_0
    :goto_1
    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {p1, p3}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    const p4, 0x7f0f00fa

    invoke-virtual {p2, p4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_3

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->b:Lchat/ola/vn/message/d;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->e()B

    move-result p1

    packed-switch p1, :pswitch_data_1

    goto :goto_2

    :pswitch_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->b:Lchat/ola/vn/message/d;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object p3

    goto :goto_2

    :pswitch_3
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->b:Lchat/ola/vn/message/d;

    check-cast p1, Lchat/ola/vn/message/v;

    invoke-virtual {p1}, Lchat/ola/vn/message/v;->D()Ljava/lang/CharSequence;

    move-result-object p1

    if-eqz p1, :cond_2

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p3

    :cond_2
    :goto_2
    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {p1, p3}, Lchat/ola/vn/m/z;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_3
    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    const p4, 0x7f0f04a6

    invoke-virtual {p2, p4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_4

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    iget-object p3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {p3}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p3

    invoke-virtual {p3}, Lchat/ola/vn/message/f;->k()S

    move-result p3

    iget-object p4, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->b:Lchat/ola/vn/message/d;

    invoke-virtual {p4}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p4

    invoke-virtual {p1, p2, p3, p4}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;SLjava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->b:Lchat/ola/vn/message/d;

    invoke-virtual {p2}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/f;->l(Ljava/lang/String;)V

    return-void

    :cond_4
    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    const p4, 0x7f0f05f4

    invoke-virtual {p2, p4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    const/4 p4, 0x1

    if-eqz p2, :cond_5

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    iget-object p5, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {p5}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p5

    invoke-virtual {p5}, Lchat/ola/vn/message/f;->k()S

    move-result p5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->b:Lchat/ola/vn/message/d;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, p2, p5, v0}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;SLjava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->b:Lchat/ola/vn/message/d;

    iput-boolean p4, p1, Lchat/ola/vn/message/d;->w:Z

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->b:Lchat/ola/vn/message/d;

    iput-object p3, p1, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    :goto_3
    invoke-static {p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->c(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Lchat/ola/vn/b/o;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/b/o;->notifyDataSetChanged()V

    return-void

    :cond_5
    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    const p3, 0x7f0f043d

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_6

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    iget-object p3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {p3}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p3

    invoke-virtual {p3}, Lchat/ola/vn/message/f;->k()S

    move-result p3

    iget-object p5, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->b:Lchat/ola/vn/message/d;

    invoke-virtual {p5}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p5

    invoke-virtual {p1, p2, p3, p5}, Lchat/ola/vn/network/OlaNetworkService;->c(Ljava/lang/String;SLjava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->b:Lchat/ola/vn/message/d;

    iput-boolean p4, p1, Lchat/ola/vn/message/d;->x:Z

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    goto :goto_3

    :cond_6
    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    const p3, 0x7f0f04d0

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->b:Lchat/ola/vn/message/d;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->c:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/widget/EditText;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;->b:Lchat/ola/vn/message/d;

    invoke-virtual {p2}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_7
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method
