.class Lchat/ola/vn/contactpicker/OlaContactPickerActivity$5;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->f(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$5;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(I)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$5;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->b(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;Z)Z

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$5;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {v0, v1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->a(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;Z)V

    const/4 v0, 0x1

    const v1, 0x7f0f00a2

    if-eq p1, v0, :cond_0

    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$5;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->a(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->selectAll()V

    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$5;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    const v0, 0x7f0f0443

    :goto_0
    invoke-static {p1, v1, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$5;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->a(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->selectAll()V

    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$5;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const v0, 0x7f0f0258

    goto :goto_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/entity/ag;)V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$5;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->a(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    move-result-object v0

    const-string v1, ""

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$5;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->a(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;Z)V

    const/4 v0, 0x0

    invoke-static {}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->B()Ljava/util/List;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/message/f;

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    move-object v0, v3

    goto :goto_0

    :cond_1
    if-nez v0, :cond_2

    new-instance v0, Lchat/ola/vn/message/f;

    invoke-direct {v0, p1, v1}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    invoke-static {}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->B()Ljava/util/List;

    move-result-object p1

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$5;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->b(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Lchat/ola/vn/contactpicker/a;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->B()Ljava/util/List;

    move-result-object v1

    invoke-virtual {p1, v1}, Lchat/ola/vn/contactpicker/a;->a(Ljava/util/List;)V

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$5;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->b(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Lchat/ola/vn/contactpicker/a;

    move-result-object p1

    invoke-virtual {p1, v0}, Lchat/ola/vn/contactpicker/a;->a(Lchat/ola/vn/message/f;)V

    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$5;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->b(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Lchat/ola/vn/contactpicker/a;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/contactpicker/a;->notifyDataSetChanged()V

    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$5;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->b(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Lchat/ola/vn/contactpicker/a;

    move-result-object p1

    iget-object p1, p1, Lchat/ola/vn/contactpicker/a;->b:Lchat/ola/vn/contactpicker/OlaContactPickerActivity$c;

    invoke-interface {p1, v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$c;->a(Lchat/ola/vn/message/f;)V

    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$5;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->c(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Z

    move-result p1

    if-eqz p1, :cond_3

    invoke-static {}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->C()Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$5;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->d(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {p1, v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;->h(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$5;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-virtual {p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    return-void
.end method
