.class Lchat/ola/vn/activity/OlaChatViewActivity$19;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatViewActivity;->v()Landroid/app/Dialog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/activity/OlaChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaChatViewActivity;Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->a:Ljava/util/List;

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
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p3, 0x7f0f0550

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 p3, 0x0

    invoke-virtual {p2, p1, p3}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p3, 0x7f0f06a7

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaVipStoreActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p3, 0x7f0f05e4

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->p(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    return-void

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p3, 0x7f0f04ad

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_3

    new-instance p1, Lchat/ola/vn/i/h;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    iget-object p3, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p4, 0x7f0f009c

    invoke-virtual {p3, p4}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p3

    iget-object p4, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p5, 0x7f0f021c

    invoke-virtual {p4, p5}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p4

    new-instance p5, Lchat/ola/vn/activity/OlaChatViewActivity$19$1;

    invoke-direct {p5, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$19$1;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity$19;)V

    invoke-direct {p1, p2, p3, p4, p5}, Lchat/ola/vn/i/h;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/i/h$a;)V

    invoke-virtual {p1}, Lchat/ola/vn/i/h;->show()V

    return-void

    :cond_3
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p3, 0x7f0f0529

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_4

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->F()Ljava/util/List;

    move-result-object p2

    iget-object p3, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1, p2, p3}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->a(Landroid/content/Context;Ljava/util/List;Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;)V

    return-void

    :cond_4
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p3, 0x7f0f0492

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_5

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "@"

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p3, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p3

    invoke-virtual {p3}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_5
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p3, 0x7f0f043a

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_6

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p2, 0x7f0f0184

    invoke-virtual {p1, p2}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p2, 0x7f0f0183

    const/4 p3, 0x1

    new-array p3, p3, [Ljava/lang/Object;

    const/4 p4, 0x0

    new-instance p5, Ljava/lang/StringBuilder;

    invoke-direct {p5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "@"

    invoke-virtual {p5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p5

    aput-object p5, p3, p4

    invoke-virtual {p1, p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p2, 0x7f0f0439

    invoke-virtual {p1, p2}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p2, 0x7f0f044d

    invoke-virtual {p1, p2}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/activity/OlaChatViewActivity$19$2;

    invoke-direct {v5, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$19$2;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity$19;)V

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;

    return-void

    :cond_6
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p3, 0x7f0f05ce

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_9

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p3, 0x7f0f05cc

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_7

    goto :goto_0

    :cond_7
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p3, 0x7f0f061f

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_8

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaCropImageActivity;->a(Landroid/content/Context;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void

    :cond_8
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p3, 0x7f0f0457

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_a

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->r(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/app/Dialog;

    return-void

    :cond_9
    :goto_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->q(Lchat/ola/vn/activity/OlaChatViewActivity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_a
    return-void
.end method
