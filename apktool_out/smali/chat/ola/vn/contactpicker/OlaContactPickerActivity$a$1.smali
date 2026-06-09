.class Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;->a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;


# direct methods
.method constructor <init>(Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a$1;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a$1;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;

    iget-object v0, v0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->b(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Lchat/ola/vn/contactpicker/a;

    move-result-object v0

    invoke-virtual {v0, p1}, Lchat/ola/vn/contactpicker/a;->b(Lchat/ola/vn/message/f;)I

    move-result p1

    if-ltz p1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a$1;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;

    iget-object v0, v0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$a;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->f(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Landroid/widget/ListView;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/widget/ListView;->smoothScrollToPosition(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
