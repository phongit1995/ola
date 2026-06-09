.class Lchat/ola/vn/contactpicker/OlaContactPickerActivity$6;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/i;


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

    iput-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$6;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Z)V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$6;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->a(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;Z)V

    if-eqz p2, :cond_3

    iget-object p2, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$6;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p2}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->a(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    move-result-object p2

    const-string v0, ""

    invoke-virtual {p2, v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    const/4 p2, 0x0

    invoke-static {}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->B()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    move-object p2, v2

    goto :goto_0

    :cond_1
    if-nez p2, :cond_2

    new-instance p2, Lchat/ola/vn/message/f;

    invoke-direct {p2, p1, v1}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    invoke-static {}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->B()Ljava/util/List;

    move-result-object p1

    invoke-interface {p1, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$6;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->b(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Lchat/ola/vn/contactpicker/a;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->B()Ljava/util/List;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/contactpicker/a;->a(Ljava/util/List;)V

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$6;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->b(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Lchat/ola/vn/contactpicker/a;

    move-result-object p1

    invoke-virtual {p1, p2}, Lchat/ola/vn/contactpicker/a;->a(Lchat/ola/vn/message/f;)V

    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$6;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->b(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Lchat/ola/vn/contactpicker/a;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/contactpicker/a;->notifyDataSetChanged()V

    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$6;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->b(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Lchat/ola/vn/contactpicker/a;

    move-result-object p1

    iget-object p1, p1, Lchat/ola/vn/contactpicker/a;->b:Lchat/ola/vn/contactpicker/OlaContactPickerActivity$c;

    invoke-interface {p1, p2}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$c;->a(Lchat/ola/vn/message/f;)V

    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$6;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->c(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Z

    move-result p1

    if-eqz p1, :cond_4

    invoke-static {}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->C()Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$6;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p2}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->d(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Ljava/util/List;

    move-result-object p2

    invoke-interface {p1, p2}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;->h(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$6;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-virtual {p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->finish()V

    return-void

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$6;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p1, v1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->b(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;Z)Z

    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$6;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    const p2, 0x7f0f009f

    const v0, 0x7f0f0443

    invoke-static {p1, p2, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_4
    return-void
.end method
