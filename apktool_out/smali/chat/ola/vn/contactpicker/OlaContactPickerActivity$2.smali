.class Lchat/ola/vn/contactpicker/OlaContactPickerActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;


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

    iput-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$2;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public b_(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$2;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->a(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    move-result-object v0

    const-string v1, ""

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$2;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {v0, p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->a(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method
