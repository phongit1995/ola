.class Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->B()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$1;->a:Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;

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
    iget-object p1, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$1;->a:Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;

    invoke-static {p1}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->a(Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;)Lchat/ola/vn/pickercontacts/h;

    move-result-object p1

    invoke-virtual {p1, p3}, Lchat/ola/vn/pickercontacts/h;->c(I)V

    iget-object p1, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$1;->a:Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;

    invoke-static {p1}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->b(Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
