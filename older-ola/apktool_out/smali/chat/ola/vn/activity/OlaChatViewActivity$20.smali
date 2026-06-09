.class Lchat/ola/vn/activity/OlaChatViewActivity$20;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatViewActivity;->aj()Landroid/app/Dialog;
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

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$20;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$20;->a:Ljava/util/List;

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
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$20;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$20;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p3, 0x7f0f061f

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$20;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$20;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaCropImageActivity;->a(Landroid/content/Context;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$20;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p3, 0x7f0f047f

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$20;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const/4 p2, 0x0

    iput-object p2, p1, Lchat/ola/vn/activity/OlaChatViewActivity;->h:Landroid/graphics/drawable/Drawable;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$20;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const/4 p3, 0x1

    iput-boolean p3, p1, Lchat/ola/vn/activity/OlaChatViewActivity;->i:Z

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$20;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    const/4 p3, 0x0

    invoke-static {p1, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->c(Lchat/ola/vn/activity/OlaChatViewActivity;Z)Z

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    iget-object p3, p0, Lchat/ola/vn/activity/OlaChatViewActivity$20;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p3

    invoke-virtual {p3}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p3

    iget-object p4, p0, Lchat/ola/vn/activity/OlaChatViewActivity$20;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p4}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p4

    invoke-virtual {p4}, Lchat/ola/vn/message/f;->k()S

    move-result p4

    invoke-static {p1, p3, p4, p2}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;Ljava/lang/String;I[B)V

    new-instance p1, Lchat/ola/vn/activity/OlaChatViewActivity$20$1;

    invoke-direct {p1, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$20$1;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity$20;)V

    const-wide/16 p2, 0x7d0

    invoke-static {p1, p2, p3}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
