.class public Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AbsListView$OnScrollListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$a;
    }
.end annotation


# instance fields
.field private e:Landroid/widget/ListView;

.field private f:Landroid/widget/EditText;

.field private g:Lchat/ola/vn/pickercontacts/h;

.field private h:Landroid/view/View;

.field private i:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/pickercontacts/c;",
            ">;"
        }
    .end annotation
.end field

.field private j:Landroid/widget/TextView;

.field private k:Landroid/view/View;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method private B()V
    .locals 3

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    new-instance v1, Landroid/graphics/drawable/ColorDrawable;

    invoke-virtual {p0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->f()I

    move-result v2

    invoke-direct {v1, v2}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v0, v1}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    const v0, 0x7f090393

    invoke-virtual {p0, v0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->k:Landroid/view/View;

    const v0, 0x7f090101

    invoke-virtual {p0, v0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09027c

    invoke-virtual {p0, v0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090263

    invoke-virtual {p0, v0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090392

    invoke-virtual {p0, v0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->j:Landroid/widget/TextView;

    const v0, 0x7f09031b

    invoke-virtual {p0, v0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->e:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->e:Landroid/widget/ListView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setDivider(Landroid/graphics/drawable/Drawable;)V

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->e:Landroid/widget/ListView;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setFastScrollEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->e:Landroid/widget/ListView;

    new-instance v1, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$1;-><init>(Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    const v0, 0x7f0901f5

    invoke-virtual {p0, v0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->f:Landroid/widget/EditText;

    const v0, 0x7f0900bc

    invoke-virtual {p0, v0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0905cf

    invoke-virtual {p0, v0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->h:Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private C()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->g:Lchat/ola/vn/pickercontacts/h;

    invoke-virtual {v0}, Lchat/ola/vn/pickercontacts/h;->a()I

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->k:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->k:Landroid/view/View;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->j:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, ""

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private D()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->i:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->i:Ljava/util/List;

    new-instance v0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$a;

    invoke-direct {v0, p0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$a;-><init>(Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;)V

    const/4 v2, 0x1

    new-array v2, v2, [Landroid/content/Context;

    aput-object p0, v2, v1

    invoke-virtual {v0, v2}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$a;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    :cond_0
    new-instance v0, Lchat/ola/vn/pickercontacts/h;

    invoke-direct {v0, p0}, Lchat/ola/vn/pickercontacts/h;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->g:Lchat/ola/vn/pickercontacts/h;

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->g:Lchat/ola/vn/pickercontacts/h;

    iget-object v1, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->i:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/pickercontacts/h;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->e:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->g:Lchat/ola/vn/pickercontacts/h;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->e:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnScrollListener(Landroid/widget/AbsListView$OnScrollListener;)V

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->g:Lchat/ola/vn/pickercontacts/h;

    invoke-virtual {v0}, Lchat/ola/vn/pickercontacts/h;->notifyDataSetChanged()V

    return-void
.end method

.method private E()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->f:Landroid/widget/EditText;

    new-instance v1, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity$2;-><init>(Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;)Lchat/ola/vn/pickercontacts/h;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->g:Lchat/ola/vn/pickercontacts/h;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;Ljava/util/List;)Ljava/util/List;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->i:Ljava/util/List;

    return-object p1
.end method

.method static synthetic b(Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->C()V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->i:Ljava/util/List;

    return-object p0
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 4

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    sparse-switch p1, :sswitch_data_0

    return-void

    :goto_0
    :sswitch_0
    invoke-virtual {p0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->finish()V

    return-void

    :sswitch_1
    const-string p1, ""

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->g:Lchat/ola/vn/pickercontacts/h;

    invoke-virtual {v0}, Lchat/ola/vn/pickercontacts/h;->c()Landroid/util/SparseBooleanArray;

    move-result-object v0

    const/4 v1, 0x0

    move-object v2, p1

    const/4 p1, 0x0

    :goto_1
    iget-object v3, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->g:Lchat/ola/vn/pickercontacts/h;

    invoke-virtual {v3}, Lchat/ola/vn/pickercontacts/h;->getCount()I

    move-result v3

    if-ge p1, v3, :cond_1

    invoke-virtual {v0, p1, v1}, Landroid/util/SparseBooleanArray;->get(IZ)Z

    move-result v3

    if-eqz v3, :cond_0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->g:Lchat/ola/vn/pickercontacts/h;

    invoke-virtual {v2, p1}, Lchat/ola/vn/pickercontacts/h;->a(I)Lchat/ola/vn/pickercontacts/c;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/pickercontacts/c;->f()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ";"

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    :cond_0
    add-int/lit8 p1, p1, 0x1

    goto :goto_1

    :cond_1
    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    const p1, 0x7f0f0361

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "smsto:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.SENDTO"

    invoke-direct {v1, v2, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    const-string v0, "sms_body"

    invoke-virtual {v1, v0, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p0, v1}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->startActivity(Landroid/content/Intent;)V

    goto :goto_0

    :sswitch_2
    iget-object p1, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->f:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->f:Landroid/widget/EditText;

    const-string v0, ""

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->g:Lchat/ola/vn/pickercontacts/h;

    invoke-virtual {p1}, Lchat/ola/vn/pickercontacts/h;->getFilter()Landroid/widget/Filter;

    move-result-object p1

    const-string v0, ""

    invoke-virtual {p1, v0}, Landroid/widget/Filter;->filter(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    :sswitch_3
    return-void

    :sswitch_data_0
    .sparse-switch
        0x7f0900bc -> :sswitch_2
        0x7f090101 -> :sswitch_1
        0x7f090263 -> :sswitch_0
        0x7f09027c -> :sswitch_0
        0x7f090417 -> :sswitch_3
    .end sparse-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0077

    invoke-virtual {p0, p1}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->B()V

    invoke-direct {p0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->D()V

    invoke-direct {p0}, Lchat/ola/vn/pickercontacts/OlaPickerContactActivity;->E()V

    return-void
.end method

.method public onScroll(Landroid/widget/AbsListView;III)V
    .locals 0

    return-void
.end method

.method public onScrollStateChanged(Landroid/widget/AbsListView;I)V
    .locals 0

    return-void
.end method
