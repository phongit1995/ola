.class Lchat/ola/vn/contactpicker/OlaContactPickerActivity$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/TextView$OnEditorActionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->D()V
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

    iput-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$3;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEditorAction(Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z
    .locals 1

    const/4 p1, 0x0

    if-eqz p3, :cond_0

    invoke-virtual {p3}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result p3

    const/16 v0, 0x42

    if-eq p3, v0, :cond_1

    :cond_0
    const/4 p3, 0x3

    if-ne p2, p3, :cond_2

    :cond_1
    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$3;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p2}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->a(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p2

    iget-object p3, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$3;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p3}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->a(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    move-result-object p3

    const-string v0, ""

    invoke-virtual {p3, v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object p3, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$3;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p3, p2}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->a(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object p2, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$3;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    iget-object p3, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$3;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p3}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->a(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    move-result-object p3

    invoke-static {p2, p3, p1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    const/4 p1, 0x1

    :catch_1
    :cond_2
    return p1
.end method
