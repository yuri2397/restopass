import { VigilShowComponent } from './../../pages/vigils/vigil-show/vigil-show.component';
import { VigilListComponent } from './../../pages/vigils/vigil-list/vigil-list.component';
import { VigilEditComponent } from './../../pages/vigils/vigil-edit/vigil-edit.component';
import { VigilCreateComponent } from './../../pages/vigils/vigil-create/vigil-create.component';
import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AdminLayoutRoutes } from './admin-layout.routing';
import { DashboardComponent } from '../../dashboard/dashboard.component';
import { UserProfileComponent } from '../../user-profile/user-profile.component';
import { TableListComponent } from '../../table-list/table-list.component';
import { TypographyComponent } from '../../typography/typography.component';
import { IconsComponent } from '../../icons/icons.component';
import { MapsComponent } from '../../maps/maps.component';
import { NotificationsComponent } from '../../notifications/notifications.component';
import { UpgradeComponent } from '../../upgrade/upgrade.component';
import {MatButtonModule} from '@angular/material/button';
import {MatInputModule} from '@angular/material/input';
import {MatRippleModule} from '@angular/material/core';
import {MatFormFieldModule} from '@angular/material/form-field';
import {MatTooltipModule} from '@angular/material/tooltip';
import {MatSelectModule} from '@angular/material/select';
import { RestoShowComponent } from 'app/pages/restos/resto-show/resto-show.component';
import { RestoCreateComponent } from 'app/pages/restos/resto-create/resto-create.component';
import { RestoEditComponent } from 'app/pages/restos/resto-edit/resto-edit.component';
import { RestoListComponent } from 'app/pages/restos/resto-list/resto-list.component';
import {MatTableModule} from '@angular/material/table'; 
import {MatIconModule} from '@angular/material/icon';
import { NzEmptyModule } from 'ng-zorro-antd/empty';
import { NzModalModule } from 'ng-zorro-antd/modal';
import { NzInputModule } from 'ng-zorro-antd/input';
import { NzFormModule } from 'ng-zorro-antd/form';
import { NzSelectModule } from 'ng-zorro-antd/select';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { QRCodeModule } from 'angular2-qrcode';
import { NzAvatarModule } from 'ng-zorro-antd/avatar';
import { UserCreateComponent } from 'app/pages/users/user-create/user-create.component';
import { UserListComponent } from 'app/pages/users/user-list/user-list.component';
import { UserShowComponent } from 'app/pages/users/user-show/user-show.component';
import { UserEditComponent } from 'app/pages/users/user-edit/user-edit.component';
import { HorairesComponent } from 'app/pages/params/horaires/horaires.component';

@NgModule({
  imports: [
    CommonModule,
    RouterModule.forChild(AdminLayoutRoutes),
    FormsModule,
    ReactiveFormsModule,
    MatButtonModule,
    MatRippleModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatTooltipModule,
    MatTableModule,
    MatIconModule,
    NzEmptyModule,
    NzModalModule,
    NzInputModule,
    NzFormModule,
    NzSelectModule,
    NzButtonModule,
    QRCodeModule,
    NzAvatarModule,
  ],
  declarations: [
    DashboardComponent,
    UserProfileComponent,
    TableListComponent,
    TypographyComponent,
    IconsComponent,
    MapsComponent,
    NotificationsComponent,
    UpgradeComponent,
    RestoListComponent,
    RestoCreateComponent,
    RestoEditComponent,
    RestoShowComponent,
    VigilCreateComponent,
    VigilEditComponent,
    VigilListComponent,
    VigilShowComponent,
    UserListComponent,
    UserCreateComponent,
    UserShowComponent,
    UserEditComponent,
    HorairesComponent,
  ]
})

export class AdminLayoutModule {}
