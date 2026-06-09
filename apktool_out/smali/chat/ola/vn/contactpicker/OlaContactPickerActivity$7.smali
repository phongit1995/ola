.class Lchat/ola/vn/contactpicker/OlaContactPickerActivity$7;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/contactpicker/OlaContactPickerActivity$c;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->E()V
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

    iput-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$7;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/message/f;)V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$7;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->d(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$7;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    new-instance v1, Ljava/util/ArrayList;

    const/16 v2, 0x64

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(I)V

    invoke-static {v0, v1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->a(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;Ljava/util/List;)Ljava/util/List;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$7;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->d(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$7;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->d(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$7;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->e(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)V

    return-void
.end method

.method public b(Lchat/ola/vn/message/f;)V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$7;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->d(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$7;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {v0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->d(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    const/4 v0, 0x0

    iget-object v1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$7;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {v1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->d(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    :goto_0
    if-ge v0, v1, :cond_2

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$7;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {v3}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->d(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/message/f;

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$7;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->d(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)Ljava/util/List;

    move-result-object p1

    invoke-interface {p1, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    goto :goto_1

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    :goto_1
    iget-object p1, p0, Lchat/ola/vn/contactpicker/OlaContactPickerActivity$7;->a:Lchat/ola/vn/contactpicker/OlaContactPickerActivity;

    invoke-static {p1}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->e(Lchat/ola/vn/contactpicker/OlaContactPickerActivity;)V

    return-void
.end method
