.class Lchat/ola/vn/countrypicker/OlaCountryPickerActivity$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity$3;->a:Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;

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
    sget-object p1, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->e:Lchat/ola/vn/countrypicker/c;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity$3;->a:Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;

    invoke-static {p1}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->b(Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;)Ljava/util/List;

    move-result-object p1

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/countrypicker/a;

    sget-object p2, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->e:Lchat/ola/vn/countrypicker/c;

    invoke-interface {p2, p1}, Lchat/ola/vn/countrypicker/c;->a(Lchat/ola/vn/countrypicker/a;)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity$3;->a:Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;

    invoke-virtual {p1}, Lchat/ola/vn/countrypicker/OlaCountryPickerActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
